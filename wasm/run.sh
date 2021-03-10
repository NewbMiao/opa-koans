#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)
{

    bundleDir="$workspace/../quick-start"
    echo "example_rbac files bundled!"
    cd "$bundleDir"
    docker run --rm -v "$bundleDir":/code -w /code openpolicyagent/opa:latest build -t wasm -e 'example_rbac/allow' -b .
    cd "$workspace" || exit

    mv "$bundleDir/"bundle.tar.gz .
    tar -xzf bundle.tar.gz /policy.wasm /data.json
    rm bundle.tar.gz

    [ "$1" = "" ] && echo "Usage: sh wasm/run.sh <input-json-string>" && exit 1
    node app.js "$1"
}

# eg:
# sh wasm/run.sh "$(cat quick-start/input.json)"
# or
# sh wasm/run.sh '{"action":{"operation":"read","resource":"widgets"},"subject":{"user":"inspector-alice"}}'
# output:
# [{"allow":true}]
