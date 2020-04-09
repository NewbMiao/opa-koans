#!/usr/bin/env sh

workspace=$(cd $(dirname $0) && pwd -P)

{
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
    exec docker-compose -f docker-compose-monitor.yaml up
}