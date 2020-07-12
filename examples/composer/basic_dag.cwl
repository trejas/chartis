class: Workflow
cwlVersion: v1.0
id: basic_dag
label: basic_dag
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs: []
outputs: []
steps:
  - id: example_start
    in:
      - id: parents
        default: {}
      - id: op_kwargs
        default: '{}'
      - id: task_id
        default: example_start
    out:
      - id: children
    run: ./operators/dummyoperator.cwl
    label: example_start
    'sbg:x': -774
    'sbg:y': -185
  - id: hello_world
    in:
      - id: parents
        default: {}
        source:
          - new_task/children
          - branch_hello/children
      - id: bash_command
        default: echo "Hello World!"
      - id: op_kwargs
        default: '{}'
      - id: provide_context
        default: true
      - id: task_id
        default: hello_world
    out:
      - id: children
    run: ./operators/bashoperator.cwl
    label: hello_world
    'sbg:x': -96
    'sbg:y': -159
  - id: branch_hello
    in:
      - id: parents
        default: {}
        source:
          - example_start/children
          - new_bash_op/children
      - id: bash_command
        default: echo "Branch hello"
      - id: op_kwargs
        default: '{}'
      - id: provide_context
        default: true
      - id: task_id
        default: branch_hello
    out:
      - id: children
    run: ./operators/bashoperator.cwl
    label: branch_hello
    'sbg:x': -261.2138366699219
    'sbg:y': -362.0366516113281
  - id: new_task
    in:
      - id: parents
        default: {}
        source: example_start/children
      - id: bash_command
        default: echo "newtask"
      - id: op_kwargs
        default: '{}'
      - id: task_id
        default: new_task
    out:
      - id: children
    run: ./operators/bashoperator.cwl
    label: new_task
    'sbg:x': -417.7433776855469
    'sbg:y': 6.981669902801514
  - id: new_bash_op
    in:
      - id: parents
        default: {}
        source: example_start/children
      - id: bash_command
        default: echo "Hello Airflow Summit"
      - id: op_kwargs
        default: '{}'
      - id: task_id
        default: new_bash_op
    out:
      - id: children
    run: operators/bashoperator.cwl
    label: new_bash_op
    'sbg:x': -508.5152893066406
    'sbg:y': -443
requirements:
  - class: MultipleInputFeatureRequirement
