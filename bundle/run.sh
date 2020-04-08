#!/usr/bin/env bash

workspace=$(cd $(dirname $0) && pwd -P)

# docker run \
#     -p 9090:9090 \
#     -v $workspace/prometheus.yml:/etc/prometheus/prometheus.yml \
#     prom/prometheus

{
    cd $workspace/example
    find . -type f ! -name "*.tar.gz" | xargs tar -czf rbac.tar.gz
    mv rbac.tar.gz ../demo-server
    echo "example_rbac files bundled!"
    cd $workspace/demo-server
    echo "start demo-server at http://localhost:8888/"

    go run main.go
}