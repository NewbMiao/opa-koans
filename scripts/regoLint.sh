#!/usr/bin/env bash
workspace=$(cd $(dirname $0) && pwd -P)
{
    cd $workspace/../
    echo "Rego Linting"
    unfmts=$(docker run --rm -v $(pwd):/code -w /code openpolicyagent/opa:latest fmt -l $(find . -type f -name '*.rego' ! -path '*/node_modules/*'))
    if [ "$unfmts" != "" ]; then
        echo "Found unforamt rego files:\n$unfmts"
        exit 1
    fi
}
