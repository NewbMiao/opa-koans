#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace"/../ || exit
    echo "Shell Linting"
    # shellcheck disable=SC2046
    docker run --rm -v "$(pwd)":/code -w /code koalaman/shellcheck:latest $(find . -type f -name '*.sh' ! -path '*/node_modules/*')
}
