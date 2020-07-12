class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: baseoperator
baseCommand: []
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
outputs:
  - id: children
    type: map?
label: baseoperator
hints:
  - class: node_type
    value: operator
  - class: operator_type
    value: BaseOperator
  - class: operator_module
    value: airflow.operators.baseoperator
