#!/usr/bin/env sh

workspace=$(cd $(dirname $0) && pwd -P)

{
    cd $workspace/example
    find . -type f ! -name "*.tar.gz" | xargs tar -czf rbac.tar.gz
    mv rbac.tar.gz ../demo-server
    echo "example_rbac files bundled!"
    cd $workspace
    docker-compose -f docker-compose.yaml up
}