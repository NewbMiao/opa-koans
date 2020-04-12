#!/usr/bin/env bash
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace"/../ || exit
    echo "Rego Testing"
    docker run --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest test -c --threshold 100 quick-start
}
