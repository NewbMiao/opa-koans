#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace" || exit
    opa build -d ../quick-start/example.rego -d ../quick-start/data.json 'data.example_rbac.allow = allow'
    [ "$1" = "" ] && echo "Usage: sh wasm/run.sh <input-json-string>" && exit 1
    node app.js "$1"
}

# eg:
# sh wasm/run.sh "$(cat quick-start/input.json)"
# or
# sh wasm/run.sh '{"action":{"operation":"read","resource":"widgets"},"subject":{"user":"inspector-alice"}}'
# output:
# [{"allow":true}]
