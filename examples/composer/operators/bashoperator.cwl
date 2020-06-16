class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: bashoperator
baseCommand: []
inputs:
  - id: parents
    type: map
  - id: bash_command
    type: string
    inputBinding:
      position: 0
  - id: depends_on_past
    type: boolean?
    inputBinding:
      position: 0
  - id: op_kwargs
    type: string
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
  - id: provide_context
    type: boolean?
  - id: priority_weight
    type: int?
    inputBinding:
      position: 0
  - id: task_id
    type: string?
    inputBinding:
      position: 0
outputs:
  - id: children
    type: map?
label: bashoperator
requirements:
  - class: ResourceRequirement
    ramMin: 1024
    coresMin: 1024
hints:
  - class: node_type
    value: operator
  - class: operator_type
    value: BashOperator
  - class: operator_module
    value: airflow.operators.bash_operator
