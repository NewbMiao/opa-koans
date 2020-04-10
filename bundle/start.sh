#!/usr/bin/env sh

workspace=$(cd $(dirname $0) && pwd -P)

start() {
  # bundle
  cd $workspace/example
  find . -type f ! -name "*.tar.gz" | xargs tar -czf rbac.tar.gz
  mv rbac.tar.gz ../docker-compose/demo-server
  echo "rbac files bundled!"

  # discovery
  cd $workspace/discovery
  find . -type f ! -name "*.tar.gz" | xargs tar -czf discovery.tar.gz
  mv discovery.tar.gz ../docker-compose/demo-server
  echo "discovery files bundled!"

  cd $workspace/docker-compose
  exec docker-compose -f docker-compose-monitor.yaml up -d
}

action="$1"
{

  case $action in
  "start")
    start
    ;;
  "stop")
    cd $workspace/docker-compose
    exec docker-compose -f docker-compose-monitor.yaml stop
    ;;
  "logs")
    [ "$2" == "" ] && echo "Please specify one below container name to see log:\n $(docker ps -a -f network=docker-compose_monitor)" && exit 1
    cId=$(docker ps -a | grep $2 | cut -d ' ' -f1)
    [ "$cId" != "" ] && docker logs -ft $cId
    ;;
  *)
    echo "Usage:\n\tsupport cmd is: start, stop, logs <container name>"
    ;;
  esac
}
