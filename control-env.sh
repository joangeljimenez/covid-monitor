#!/usr/bin/env bash
function start {
  echo 'Starting Docker environment . . .'
  docker-compose --project-name covid-monitor up -d
}

function stop {
  echo 'Stoping environment . . .'
  docker-a compose --project-name covid-monitor down
}

function token {
  echo 'Notebook Token:'
  SERVER=$(docker exec -it jupyter jupyter notebook list)
  echo "${SERVER}" | grep '/notebook' | sed -E 's/^.*=([a-z0-9]+).*$/\1/'
}

function superset-init {
  echo 'Initializing Superset database using sqlite'
  docker exec -it superset superset-init
}

function superset-import {
  echo 'trying to import /home/superset/dashboards/covid_vaccine.json dashboard . . .'
  docker exec -it superset superset import-dashboards -p /home/superset/dashboards/covid_vaccine.json
}

function cleanup {
  echo "Removing volume"
  docker volume rm covid-monitor_postgres-data
  docker volume rm covid-monitor_superset
  docker volume rm covid-monitor_postgres-airflow-data
}

function psql {
  docker exec -it postgres psql -U covid covid
}

case $1 in

start)
  start
  ;;

stop)
  stop
  ;;

token)
  token
  ;;

superset-init)
  superset-init
  ;;

superset-ip)
  superset-ip
  ;;

superset-import)
  superset-import
  ;;

cleanup)
  cleanup
  ;;

*)
  printf "ERROR: Missing command\n  Usage: $(basename $0) (start|stop|cleanup|token|logs|update|superset-start|superset-stop|superset-init)\n"
  exit 1
  ;;
esac