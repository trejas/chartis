# Chartis CWL DAG
# This class allows the creation of a DAG from a CWL input document.
from airflow import DAG
from functools import partial
from datetime import datetime, timedelta, date
import importlib
import json
import logging
from operator import methodcaller
from ruamel.yaml import YAML
from typing import Union


class CWLDag(DAG):
    """
        Produces a DAG from a config file, this file can come from a local JSON
        document (Using Common Workflow Language), with additional DAG params, or a set of params stored in a
        sqlalchemy database source.
    """

    def __init__(
        self, input_dict: dict, dag_id: str = None, start_date: datetime = None
    ) -> CWLDag:
        self.relationships = []
        self.nodes = []
        self.input_dict = input_dict
        self.tasks_list = []

        # Airflow DAG attributes
        self.dag_id = dag_id
        self.default_args = {}
        self.params = {}
        self.task_dict = {}
        self.end_date = None
        super().__init__(dag_id=dag_id, start_date=start_date)
        self.parse_dag_nodes_and_relationships()
        self.define_relationships()

    @classmethod
    def from_json(
        cls, input_json_path: str, dag_id: str, start_date: datetime = None
    ) -> CWLDag:
        with open(input_json_path, "r") as stream:
            try:
                input_dict = json.load(stream)
            except ValueError as err:
                logging.error(err)
        return cls(input_dict, dag_id, start_date)

    @classmethod
    def from_yaml(
        cls, input_yaml_path: str, dag_id: str, start_date: datetime = None
    ) -> CWLDag:
        yaml = YAML(typ="safe")  # default, if not specfied, is 'rt' (round-trip)

        with open(input_yaml_path, "r") as stream:
            try:
                input_dict = yaml.load(stream)
            except yaml.YAMLError as err:
                logging.error(err)
        return cls(input_dict, dag_id, start_date)

    def _get_nodes(self, node: dict, target_key: str, target_value: str) -> list:
        # Finds the nodes with the id of parents.
        def find_node_value(
            node, target_key: str, target_value: str
        ) -> Union[dict, str]:
            return node[target_key] == target_value

        return list(
            filter(
                partial(
                    find_node_value, target_key=target_key, target_value=target_value
                ),
                node,
            )
        )

    def _parse_parent_nodes_and_relationships(self, node: dict) -> dict:
        """
            Parse a node and return its parents.
        """

        parents_node = self._get_nodes(
            node["in"], target_key="id", target_value="parents"
        )

        # Does this node have parents?
        if "source" in parents_node[0].keys():
            # If source exists, overwrite parents list with source node.
            parents = parents_node[0]["source"]
            if isinstance(
                parents, list
            ):  # Is a list if more than one parent, otherwise is string.
                # Split parents list items on Slash and return first element.
                return list(
                    map(
                        methodcaller("pop", 0), map(methodcaller("split", "/"), parents)
                    )
                )
            elif isinstance(parents, str):
                return [parents.split("/")[0]]
            else:
                raise ValueError(
                    "Parents object does not match known pattern, source node must be a list or a string."
                )
        else:
            # This node is an orphan and must be a Root/Starting Node.
            return []

    def _parse_kwargs(self, node: dict, node_kwargs: dict) -> dict:
        for port in node["in"]:
            if port["id"] != "parents" or port["id"] != "subdag_kwargs":
                node_kwargs[port["id"]] = port["default"]
        return node_kwargs

    def _parse_cwl_node(self, node: dict) -> None:

        node_type = self._get_nodes(
            node["run"]["hints"], target_key="class", target_value="node_type"
        )

        # Check for only one specified node type.
        if len(node_type) > 1:
            raise ValueError("You have too many node types, ONLY ONE!")

        if node_type[0]["value"] == "operator":  # Branch = operator type

            # Op kwargs from the definition string.
            op_kwargs = self._get_nodes(
                node["in"], target_key="id", target_value="op_kwargs"
            )[0]["default"]

            # Check output from filter and find. value should be a string.
            if not isinstance(op_kwargs, str):
                raise TypeError(
                    f"op_kwargs for {node['id']}, should have parsed to a string. Is type {type(op_kwargs)}"
                )

            try:
                # Parse dictionary from the op kwargs input string. (JSON)
                op_kwargs = json.loads(op_kwargs)
            except ValueError:
                logging.error("Op Kwargs string not valid json.")

            # Find the parents node, parse the relationships
            relationships = self._parse_parent_nodes_and_relationships(node)

            # Grab kwargs from operator input definition and build dictionary.
            op_kwargs = self._parse_kwargs(node, op_kwargs)

            try:
                # Store the operator module name
                op_module = self._get_nodes(
                    node["run"]["hints"],
                    target_key="class",
                    target_value="operator_module",
                )[0]["value"]
            except IndexError as e:
                logging.error("Error in storing operator module name...")
                logging.error(node)
                logging.error(e)
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            try:
                # Store the operator type
                op_type = self._get_nodes(
                    node["run"]["hints"],
                    target_key="class",
                    target_value="operator_type",
                )[0]["value"]
            except IndexError as e:
                logging.error("Error in storing operator type...")
                logging.error(node)
                logging.error(e)
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            try:
                # Dynamic import of operator module.
                imported_module = importlib.import_module(op_module)
            except ModuleNotFoundError as err:
                logging.error(
                    f"Module {op_module}, listed in dag definition not found. Check your spelling or if the module exists."
                )
                raise
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            try:
                # Dynamic import of operator class from module.
                op_function = getattr(imported_module, op_type)
            except AttributeError:
                logging.error(
                    f"Bad classname {op_type} not found in module {imported_module}"
                )
                raise
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            # Attach operator class to the dag.
            try:
                logging.debug(op_kwargs)
                task_operator = op_function(dag=self, **op_kwargs)
            except IndexError as e:
                logging.error("Bad node found..., Bad node, bad...")
                logging.error(e)
                raise

            # Return a tuple of the operator and its relationships
            return (task_operator, relationships)

        elif node_type[0]["value"] == "subdag":  # Branch = subdag type

            # # Subdag kwargs from the definition string.
            subdag_kwargs = self._get_nodes(
                node["in"], target_key="id", target_value="subdag"
            )[0]["default"]

            try:
                # Parse dictionary from the subdag kwargs input string. (JSON)
                subdag_kwargs = json.loads(subdag_kwargs)
            except ValueError:
                logging.error("Subdag Kwargs string not valid json.")

            # Find the parents node, parse the relationships
            relationships = self._parse_parent_nodes_and_relationships(node)

            # Attach the other node attributes to the parsed_op_kwargs dict
            subdag_kwargs = self._parse_kwargs(node, subdag_kwargs)

            try:
                # Store the subdag name
                subdag_module_name = self._get_nodes(
                    node["run"]["hints"],
                    target_key="class",
                    target_value="subdag_module",
                )[0]["value"]
            except IndexError as e:
                logging.error("Error in storing subdag name...")
                logging.error(node)
                logging.error(e)
                raise
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)
                raise

            try:
                # Store the operator type
                subdag_type = self._get_nodes(
                    node["run"]["hints"], target_key="class", target_value="subdag_type"
                )[0]["value"]
            except IndexError as e:
                logging.error("Error in storing subdag type...")
                logging.error(node)
                logging.error(e)
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            try:
                # Dynamic import of subdag module.
                imported_module = importlib.import_module(subdag_module_name)
            except ModuleNotFoundError as err:
                logging.error(
                    f"Module {subdag_module_name}, listed in dag definition not found. Check your spelling or if the module exists."
                )
                raise
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            try:
                # Dynamic import of subdag class from module.
                subdag_function = getattr(imported_module, subdag_type)
            except AttributeError:
                logging.error(
                    f"Bad classname {subdag_type} not found in module {imported_module}"
                )
                raise
            except Exception as e:
                logging.error("Other error...")
                logging.error(e)

            # Create task object
            task_subdag = subdag_function(
                dag=self, DAG_NAME=self.dag_id, task_id=node["id"], **subdag_kwargs
            )

            # Return task object, relationships
            return (task_subdag, relationships)

    def parse_dag_nodes_and_relationships(self) -> list:
        for node in self.input_dict["steps"]:
            logging.debug(node)
            logging.debug("Adding task to dag...")
            task = self._parse_cwl_node(node)

            self.tasks_list.append(task)
        return self.tasks_list

    def define_relationships(self) -> None:
        """
            Iterate through the collected tuples of tasks and relationships.
            When relationships are found, set the upstream task for task given
            in tuple.

            Dag will not properly define and render if the relationships are not
            correctly parsed and set.
        """
        logging.debug(self.tasks_list)
        for task in self.tasks_list:
            # If task tuple second element length is greater than zero it has relationships
            if len(task[1]) > 0:
                for relationship in task[1]:
                    """
                        Iterates through list of tasks defined for DAG. If the
                        the "related task" name is the same as the current iterated
                        dag task name, set the upstream relationship.
                    """
                    related_task = next(
                        (
                            task_up
                            for task_up in self.tasks
                            if task_up.task_id == relationship.split("/")[0]
                        ),
                        None,
                    )
                    try:
                        task[0].set_upstream(related_task)
                    except Exception as err:
                        logging.error("Bad relationship found, dumping outputs...")
                        logging.debug(task)
                        logging.debug(related_task)
                        logging.error(err)
                        raise airflow.exceptions.AirflowException
