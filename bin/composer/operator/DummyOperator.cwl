$namespaces:
  sbg: https://www.sevenbridges.com/
baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: node_type
  value: operator
- class: operator_type
  value: DummyOperator
- class: operator_module
  value: airflow.operators.dummy_operator
id: DummyOperator
inputs:
- 'sbg:toolDefaultValue': type
  id: task_id
  inputBinding:
    position: 0
  type: string
- id: owner
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: email
  inputBinding:
    position: 0
  type: string
- id: email_on_retry
  inputBinding:
    position: 0
  type: boolean
- id: email_on_failure
  inputBinding:
    position: 0
  type: boolean
- id: retries
  inputBinding:
    position: 0
  type: int
- 'sbg:toolDefaultValue': timedelta
  id: retry_delay
  inputBinding:
    position: 0
  type: string
- id: retry_exponential_backoff
  inputBinding:
    position: 0
  type: boolean
- 'sbg:toolDefaultValue': NoneType
  id: max_retry_delay
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: start_date
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: end_date
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: schedule_interval
  inputBinding:
    position: 0
  type: string
- id: depends_on_past
  inputBinding:
    position: 0
  type: boolean
- id: wait_for_downstream
  inputBinding:
    position: 0
  type: boolean
- 'sbg:toolDefaultValue': NoneType
  id: dag
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: params
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: default_args
  inputBinding:
    position: 0
  type: string
- id: priority_weight
  inputBinding:
    position: 0
  type: int
- id: weight_rule
  inputBinding:
    position: 0
  type: string
- id: queue
  inputBinding:
    position: 0
  type: string
- id: pool
  inputBinding:
    position: 0
  type: string
- id: pool_slots
  inputBinding:
    position: 0
  type: int
- 'sbg:toolDefaultValue': NoneType
  id: sla
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: execution_timeout
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: on_failure_callback
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: on_success_callback
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: on_retry_callback
  inputBinding:
    position: 0
  type: string
- id: trigger_rule
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: resources
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: run_as_user
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: task_concurrency
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: executor_config
  inputBinding:
    position: 0
  type: string
- id: do_xcom_push
  inputBinding:
    position: 0
  type: boolean
- 'sbg:toolDefaultValue': NoneType
  id: inlets
  inputBinding:
    position: 0
  type: string
- 'sbg:toolDefaultValue': NoneType
  id: outlets
  inputBinding:
    position: 0
  type: string
label: DummyOperator
outputs:
- id: children
  type: map?
