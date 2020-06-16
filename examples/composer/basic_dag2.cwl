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
    run:
      class: CommandLineTool
      cwlVersion: v1.0
      $namespaces:
        sbg: 'https://www.sevenbridges.com/'
      id: dummyoperator
      baseCommand: []
      inputs:
        - id: parents
          type: map?
        - id: task_id
          type: string
          inputBinding:
            position: 0
        - 'sbg:toolDefaultValue': '{}'
          id: op_kwargs
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
    label: example_start
    'sbg:x': -778
    'sbg:y': -214
  - id: hello_world
    in:
      - id: parents
        default: {}
        source:
          - new_task/children
          - branch_hello2/children
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
    run:
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
        - id: op_kwargs
          type: string
          inputBinding:
            position: 0
        - id: task_id
          type: string?
          inputBinding:
            position: 0
        - id: depends_on_past
          type: boolean?
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
    run:
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
        - id: op_kwargs
          type: string
          inputBinding:
            position: 0
        - id: task_id
          type: string?
          inputBinding:
            position: 0
        - id: depends_on_past
          type: boolean?
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
    run:
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
        - id: op_kwargs
          type: string
          inputBinding:
            position: 0
        - id: task_id
          type: string?
          inputBinding:
            position: 0
        - id: depends_on_past
          type: boolean?
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
    label: new_task
    'sbg:x': -451
    'sbg:y': -26
  - id: branch_hello2
    in:
      - id: parents
        default: {}
        source: branch_hello/children
      - id: bash_command
        default: echo "Branch hello2"
      - id: op_kwargs
        default: '{}'
      - id: task_id
        default: branch_hello2
      - id: provide_context
        default: true
    out:
      - id: children
    run:
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
        - id: op_kwargs
          type: string
          inputBinding:
            position: 0
        - id: task_id
          type: string?
          inputBinding:
            position: 0
        - id: depends_on_past
          type: boolean?
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
    label: branch_hello2
    'sbg:x': -308.8203125
    'sbg:y': -453.5
requirements:
  - class: MultipleInputFeatureRequirement
