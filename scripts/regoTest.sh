#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    opa_version="${1:-latest}"
    cd "$workspace"/../ || exit
    echo "Rego Testing"
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:"$opa_version" test -c --threshold 100 quick-start
}
