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
      - id: task_id
        default: example_start
      - id: op_kwargs
        default: '{}'
    out:
      - id: children
    run: ./operators/dummyoperator.cwl
    label: example_start
    'sbg:x': -778
    'sbg:y': -214
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
      - id: task_id
        default: hello_world
      - id: provide_context
        default: true
    out:
      - id: children
    run: ./operators/bashoperator.cwl
    label: hello_world
    'sbg:x': -53
    'sbg:y': -134
  - id: branch_hello
    in:
      - id: parents
        default: {}
        source: example_start/children
      - id: bash_command
        default: echo "Branch hello"
      - id: op_kwargs
        default: '{}'
      - id: task_id
        default: branch_hello
      - id: provide_context
        default: true
    out:
      - id: children
    run: ./operators/bashoperator.cwl
    label: branch_hello
    'sbg:x': -506
    'sbg:y': -408
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
    'sbg:x': -451
    'sbg:y': -26
requirements:
  - class: MultipleInputFeatureRequirement
