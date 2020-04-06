#!/usr/bin/env bash

workspace=$(cd $(dirname $0) && pwd -P)
{
    cd $workspace
    opa build -d ../quick-start/example.rego -d ../quick-start/data.json 'data.example_rbac.allow = allow'
    node app.js $1
}

# eg:
# sh wasm/run.sh '{"action":{"operation":"read","resource":"widgets"},"subject":{"user":"inspector-alice"}}'
# output:
# [{"allow":true}]