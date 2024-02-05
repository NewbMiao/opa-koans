#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    opa_version="${1:-latest}"
    cd "$workspace"/../ || exit
    echo "Rego Linting"
    # shellcheck disable=SC2046
    unfmts=$(docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:"$opa_version" fmt -l $(find . -type f -name '*.rego' ! -path '*/node_modules/*' ! -path '*/.go-cache/*'))
    if [ "$unfmts" != "" ]; then
        echo "Found unforamt rego files:"
        echo "$unfmts"
        exit 1
    fi
}
# fix fmt issue: opa fmt -w .
