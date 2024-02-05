#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    opa_version="${1:-latest}"
    cd "$workspace"/../ || exit
    echo "Rego Fmting"
    # shellcheck disable=SC2046
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:"${opa_version}" fmt -w $(find . -type f -name '*.rego' ! -path '*/node_modules/*' ! -path '*/.go-cache/*')
}
