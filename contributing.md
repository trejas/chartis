# How to add an operator
Copy `examples/composer/baseoperator.cwl`
Name the new file the same name as your target operator.

Ex. bashoperator.cwl == BashOperator

Add new operator parameters to the `inputs` Array in the cwl file. CWL follows YAML conventions for arrays. In addition, you will need to complete the `hints` section of the CWL file. See examples of both sections below.


## Inputs
To mark a parameter as optional, put a `?` after the type designation.

An example of a required string param:
```
- id: task_id
  type: string
  inputBinding:
    position: 0
```

An example of an optional string param:
```
- id: owner
  type: string?
  inputBinding:
    position: 0
```


Sample inputs section from the baseoperator.cwl file.
```
inputs:
  - id: parents
    type: map
  - id: task_id
    type: string
    inputBinding:
      position: 0
  - id: owner
    type: string
    inputBinding:
      position: 0
  - id: email
    type: string
    inputBinding:
      position: 0
  - id: email_on_retry
    type: boolean?
    inputBinding:
      position: 0
  - id: email_on_failure
    type: boolean?
    inputBinding:
      position: 0
  - id: retries
    type: string
    inputBinding:
      position: 0
  - id: retry_delay
    type: string
    inputBinding:
      position: 0
  - id: retry_exponential_backoff
    type: boolean?
    inputBinding:
      position: 0
  - 'sbg:category': datetime.timedelta'
    id: max_retry_delay
    type: string?
    inputBinding:
      position: 0
  - id: start_date
    type: string?
    inputBinding:
      position: 0
    label: datetime.datetime
  - 'sbg:category': datetime.datetime
    id: end_date
    type: string?
    inputBinding:
      position: 0
  - id: depends_on_past
    type: boolean?
    inputBinding:
      position: 0
  - id: wait_for_downstream
    type: boolean?
    inputBinding:
      position: 0
  - id: priority_weight
    type: int?
    inputBinding:
      position: 0
  - id: weight_rule
    type: string?
    inputBinding:
      position: 0
  - id: queue
    type: string?
    inputBinding:
      position: 0
  - id: pool
    type: string?
    inputBinding:
      position: 0
  - 'sbg:category': datetime.timedelta
    id: sla
    type: string?
    inputBinding:
      position: 0
  - 'sbg:category': datetime.timedelta
    id: execution_timeout
    type: string?
    inputBinding:
      position: 0
  - 'sbg:category': callable
    id: on_failure_callback
    type: string?
    inputBinding:
      position: 0
  - 'sbg:category': callable
    id: on_execute_callback
    type: File?
    inputBinding:
      position: 0
  - 'sbg:category': callable
    id: on_success_callback
    type: File?
    inputBinding:
      position: 0
  - id: trigger_rule
    type: string?
    inputBinding:
      position: 0
  - 'sbg:category': dict
    id: resources
    type: string?
    inputBinding:
      position: 0
  - id: run_as_user
    type: string?
    inputBinding:
      position: 0
  - id: task_concurrency
    type: int?
    inputBinding:
      position: 0
  - 'sbg:category': dict
    id: executor_config
    type: string?
  - id: do_xcom_push
    type: boolean?
    inputBinding:
      position: 0

```

## Hints
The hints section provides information to the CWL dag parser to allow it to dynamically load the operator/task into the dag. You must provide three hints to the parser:
* `node_type`: enum - either operator or subdag. Operators and Subdags are treated differently by the parser.
* `operator_type`: This is the operator class name. Ex. `BaseOperator`, `BashOperator`, `PythonOperator`. These must follow the correct capitalization.
* `operator_module`: This is the dot path to the module containing the Class definition (Or the same path you would use in an import statement). Ex. for the BaseOperator this is `airflow.operators.baseoperator`


Example `hints` section:
```
hints:
  - class: node_type
    value: operator
  - class: operator_type
    value: BaseOperator
  - class: operator_module
    value: airflow.operators.baseoperator
```