from airflow import DAG
from datetime import datetime, timedelta
from chartis.cwl import CWLDag

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2020, 2, 1, hour=2, minute=0),
    "email": ["airflow@example.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

# Test Code
test_dag = CWLDag.from_yaml(
    "dags/yaml/basic_dag.yaml", "test_cwl_dag", start_date=default_args["start_date"]
)
