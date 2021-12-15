"""ETL vaccine covid WIP"""
from datetime import datetime
from pathlib import Path

from airflow.models import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator


default_args = {'owner': 'jose', 'retries': 0, 'start_date': datetime(2021, 10, 10)}
with DAG(
    'etl_vaccine', default_args=default_args, schedule_interval='0 4 * * *'
) as dag:
    dummy_start_task = DummyOperator(task_id=f'dummy_start')