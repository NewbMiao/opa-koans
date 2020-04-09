#!/usr/bin/env sh

workspace=$(cd $(dirname $0) && pwd -P)

# docker run \
#     -p 9090:9090 \
#     -v $workspace/prometheus.yml:/etc/prometheus/prometheus.yml \
#     prom/prometheus

{
    cd $workspace
    echo "start demo-server at http://0.0.0.0:8888/ (inside docker: demo-server:8888)"

    go run main.go
}