#!/usr/bin/env sh

workspace=$(cd $(dirname $0) && pwd -P)

bundle() {
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
}

action="$1"
{
  case $action in
  "start")
    bundle
    cd $workspace/docker-compose
    docker-compose -f docker-compose-slim.yaml up -d
    ;;
  "stop")
    cd $workspace/docker-compose
    docker-compose -f docker-compose-slim.yaml stop
    ;;
  "start-advance")
    bundle
    cd $workspace/docker-compose
    docker-compose -f docker-compose-slim.yaml -f docker-compose-advance.yaml up -d
    ;;
  "stop-advance")
    cd $workspace/docker-compose
    docker-compose -f docker-compose-slim.yaml -f docker-compose-advance.yaml stop
    ;;
  "logs")
    [ "$2" == "" ] && echo "Please specify one below container name to see log:\n $(docker ps -f network=docker-compose_monitor)" && exit 1
    cId=$(docker ps | grep $2 | cut -d ' ' -f1 | head -n1)
    [ "$cId" != "" ] && docker logs -ft $cId
    ;;
  "opa-ping")
    curl -s 0.0.0.0:8181/v1/data/rbac/allow -d "{\"input\": $(cat $workspace/../quick-start/input.json)}"
    ;;
  *)
    echo "Usage:\n\tsupport cmd is: start, stop, start-advance, stop-advance, logs <container name>"
    ;;
  esac
}
