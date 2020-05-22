#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace"/../ || exit
    echo "Rego Fmting"
    # shellcheck disable=SC2046
    docker run --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest fmt -w $(find . -type f -name '*.rego' ! -path '*/node_modules/*' ! -path '*/.go-cache/*')
}
