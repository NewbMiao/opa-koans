#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace"/../ || exit
    echo "Yaml Linting"
    # shellcheck disable=SC2046
    docker run --platform linux/amd64 --rm -v "$(pwd)":/workdir giantswarm/yamllint -d "{extends: relaxed, rules: {line-length: {max: 120}}}"  $(find . -type f \( -name '*.yaml' -or -name '*.yml' \) ! -path '*/.github/*' ! -path '*/.go-cache/*' ! -path '*/node_modules/*')
}
