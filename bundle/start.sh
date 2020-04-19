#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)
listContainer="docker ps -f network=docker-compose_monitor"
dockerComposeDir="$workspace/docker-compose"

action="$1"

{
  case "$action" in
  "start")
    sh "$dockerComposeDir"/demo-server/build.sh linux
    cd "$dockerComposeDir" || exit
    docker-compose -f docker-compose-slim.yaml up -d
    ;;
  "stop")
    cd "$dockerComposeDir" || exit
    docker-compose -f docker-compose-slim.yaml down --remove-orphans
    ;;
  "start-advance")
    sh "$dockerComposeDir"/demo-server/build.sh linux
    cd "$dockerComposeDir" || exit
    docker-compose -f docker-compose-slim.yaml -f docker-compose-advance.yaml up -d
    ;;
  "stop-advance")
    cd "$dockerComposeDir" || exit
    docker-compose -f docker-compose-slim.yaml -f docker-compose-advance.yaml down --remove-orphans
    ;;
  "logs")
    [ "$2" = "" ] && echo "Please specify one below container name to see log:" && $listContainer && exit 1
    cId=$(docker ps | grep "$2" | cut -d ' ' -f1 | head -n1)
    [ "$cId" != "" ] && docker logs -ft "$cId"
    ;;
  "decision-log")
    [ "$2" = "" ] && echo "Please provide decision_id" && exit 1
    docker logs golang 2>&1 | grep "$2" --color
    ;;
  "opa-ping")
    # demo-sever `go run` way: wait go mod download fininshed
    # "$workspace"/wait-for-it.sh 0.0.0.0:8888/auth echo "demo-server is ready!"
    secs="${2:-1}"
    echo "Will ping opa-bundle after ${secs}s ..."
    sleep "$secs"
    input=$(cat "$workspace/../quick-start/input.json")
    inputWrap="{\"input\": $input}"
    # go lib opa
    curl -s 0.0.0.0:8888/auth -d "$input"
    echo
    # opa bundle
    curl -s 0.0.0.0:8181/v1/data/rbac/allow -d "$inputWrap"
    echo
    # opa discovery
    curl -s 0.0.0.0:8182/v1/data/rbac/allow -d "$inputWrap"
    ;;
  "clean")
    echo "Will clean these container:"
    $listContainer -a
    echo
    # shellcheck disable=SC2046
    docker rm -f -v $($listContainer -a -q)
    echo "Will clean network:"
    docker network rm docker-compose_monitor
    ;;
  *)
    cat <<EOF

Usage:
  slim-version monitor:     start, stop
  advance-version monitor:  start-advance, stop-advance
  container logs:           logs <container name>
  clean all container:      clean
  test opa service:         opa-ping
  query opa decision:       decision-log <decision_id>
EOF
    ;;
  esac
}
