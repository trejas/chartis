from inspect import signature
import yaml
from airflow.models.dagbag import DagBag
from airflow.models import BaseOperator
from airflow.sensors.base_sensor_operator import BaseSensorOperator

# Initializing DagBag to load all operators and sensors.
dagbag = DagBag()

def inheritors(class_obj):
    subclasses = set()
    work = [class_obj]
    while work:
        parent = work.pop()
        for child in parent.__subclasses__():
            if child not in subclasses:
                subclasses.add(child)
                work.append(child)
    return subclasses

def generate_input_from_param(param):
    return {'id':param.name,'type':param.default.__class__.__name__,'inputBinding':{'position':0}}

def generate_inputs_from_module(module):
    return list(map(generate_input_from_param,list(filter(lambda x:x.name not in ['self','args','kwargs'],signature(module.__init__).parameters.values()))))

def create_operator_cwl(operator,op_type='operator',additional_inputs=[]):
    inputs = generate_inputs_from_module(operator)

    cwl = {
        'id':operator.__name__,
        'label':operator.__name__,
        'inputs':inputs+additional_inputs,
        'baseCommand': [],
        'hints':[
            {'class':'node_type','value':op_type},
            {'class':'operator_type','value':operator.__name__},
            {'class':'operator_module','value':operator.__module__},
        ],
        'outputs':[{'id': 'children','type': 'map?'}],
        'class':'CommandLineTool',
        'cwlVersion':'v1.0',
        '$namespaces':{'sbg':'https://www.sevenbridges.com/'}
    }
    with open('composer/{}/{}.cwl'.format(op_type,operator.__name__), 'w') as file:
        yaml.dump(cwl, file,sort_keys=True)

base_operator_inputs = generate_inputs_from_module(BaseOperator)
base_sensor_inputs = generate_inputs_from_module(BaseSensorOperator)+base_operator_inputs

sensors = list(inheritors(BaseSensorOperator))
operators = list(filter(lambda x:x.__name__ not in list(map(lambda y:y.__name__,sensors+[BaseSensorOperator])) ,inheritors(BaseOperator) ))

print('Processing {} Sensors.'.format('len(sensors)'))
for sensor in sensors:
    create_operator_cwl(sensor,'sensor',base_sensor_inputs)

print('Processing {} Operators.'.format('len(sensors)'))
for operator in operators:
    create_operator_cwl(operator,'operator',base_operator_inputs)

print('Processing Complete.')
