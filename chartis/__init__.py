# This is the class you derive to create a plugin
from airflow.plugins_manager import AirflowPlugin
from chartis.__about__ import ascii_chartis_logo
import logging


logging.info(ascii_chartis_logo)

# Defining the plugin class
class Chartis(AirflowPlugin):
    name = "chartis"
