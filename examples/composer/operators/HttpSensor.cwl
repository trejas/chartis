class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: _http_sensor
baseCommand: []
inputs:
  - id: endpoint
    type: type
    inputBinding:
      position: 0
  - id: http_conn_id
    type: string
    inputBinding:
      position: 0
  - id: method
    type: string
    inputBinding:
      position: 0
  - id: request_params
    type: NoneType
    inputBinding:
      position: 0
  - id: headers
    type: NoneType
    inputBinding:
      position: 0
  - id: response_check
    type: NoneType
    inputBinding:
      position: 0
  - id: extra_options
    type: NoneType
    inputBinding:
      position: 0
  - id: poke_interval
    type: int
    inputBinding:
      position: 0
  - id: timeout
    type: int
    inputBinding:
      position: 0
  - id: soft_fail
    type: bool
    inputBinding:
      position: 0
  - id: mode
    type: str
    inputBinding:
      position: 0
  - id: task_id
    type: type
    inputBinding:
      position: 0
  - id: owner
    type: str
    inputBinding:
      position: 0
  - id: email
    type: NoneType
    inputBinding:
      position: 0
  - id: email_on_retry
    type: bool
    inputBinding:
      position: 0
  - id: email_on_failure
    type: bool
    inputBinding:
      position: 0
  - id: retries
    type: int
    inputBinding:
      position: 0
  - id: retry_delay
    type: timedelta
    inputBinding:
      position: 0
  - id: retry_exponential_backoff
    type: bool
    inputBinding:
      position: 0
  - id: max_retry_delay
    type: NoneType
    inputBinding:
      position: 0
  - 'sbg:toolDefaultValue': Datetime
    id: start_date
    type: string
  - 'sbg:toolDefaultValue': Datetime
    id: end_date
    type: string
    inputBinding:
      position: 0
  - id: schedule_interval
    type: NoneType
    inputBinding:
      position: 0
  - id: depends_on_past
    type: bool
    inputBinding:
      position: 0
  - id: wait_for_downstream
    type: bool
    inputBinding:
      position: 0
  - id: dag
    type: NoneType
    inputBinding:
      position: 0
  - id: params
    type: NoneType
    inputBinding:
      position: 0
  - id: default_args
    type: NoneType
    inputBinding:
      position: 0
  - id: priority_weight
    type: int
    inputBinding:
      position: 0
  - id: weight_rule
    type: str
    inputBinding:
      position: 0
  - id: queue
    type: str
    inputBinding:
      position: 0
  - id: pool
    type: str
    inputBinding:
      position: 0
  - id: pool_slots
    type: int
    inputBinding:
      position: 0
  - id: sla
    type: NoneType
    inputBinding:
      position: 0
  - id: execution_timeout
    type: NoneType
    inputBinding:
      position: 0
  - id: on_failure_callback
    type: NoneType
    inputBinding:
      position: 0
  - id: on_success_callback
    type: NoneType
    inputBinding:
      position: 0
  - id: on_retry_callback
    type: NoneType
    inputBinding:
      position: 0
  - id: trigger_rule
    type: str
    inputBinding:
      position: 0
  - id: resources
    type: NoneType
    inputBinding:
      position: 0
  - id: run_as_user
    type: NoneType
    inputBinding:
      position: 0
  - id: task_concurrency
    type: NoneType
    inputBinding:
      position: 0
  - id: executor_config
    type: NoneType
    inputBinding:
      position: 0
  - id: do_xcom_push
    type: bool
    inputBinding:
      position: 0
  - id: inlets
    type: NoneType
    inputBinding:
      position: 0
  - id: outlets
    type: NoneType
    inputBinding:
      position: 0
outputs:
  - id: children
    type: map?
label: HttpSensor
hints:
  - class: node_type
    value: sensor
  - class: operator_type
    value: HttpSensor
  - class: operator_module
    value: airflow.sensors.http_sensor
