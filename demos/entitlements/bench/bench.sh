#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

{
    echo "start build opa bundle ... # format: rego"
    cd "$workspace/.." || exit
    opa  build -b . -O 1 -e entitlements/main -t rego
    echo "entitlements files bundled with optmization!"
    opa run  bundle.tar.gz -s --addr 0.0.0.0:8181
}
