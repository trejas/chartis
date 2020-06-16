class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: dummyoperator
baseCommand: []
inputs:
  - id: parents
    type: map?
  - 'sbg:toolDefaultValue': '{}'
    id: op_kwargs
    type: string
    inputBinding:
      position: 0
  - id: task_id
    type: string
    inputBinding:
      position: 0
outputs:
  - id: children
    type: string?
label: dummyoperator
hints:
  - class: node_type
    value: operator
  - class: operator_type
    value: DummyOperator
  - class: operator_module
    value: airflow.operators.dummy_operator
