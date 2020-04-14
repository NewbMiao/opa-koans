#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace"/../ || exit
    echo "Rego Linting"
    # shellcheck disable=SC2046
    unfmts=$(docker run --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest fmt -l $(find . -type f -name '*.rego' ! -path '*/node_modules/*' ! -path '*/.go-cache/*'))
    if [ "$unfmts" != "" ]; then
        echo "Found unforamt rego files:"
        echo "$unfmts"
        exit 1
    fi
}
# fix fmt issue: opa fmt -w .
