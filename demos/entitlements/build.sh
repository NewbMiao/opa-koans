#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace" || exit
    files=$(ls -1 *.rego | grep -v _test.rego | xargs)
    opa build -t wasm -e entitlements $files
    tar -xf bundle.tar.gz "/policy.wasm"
    mv policy.wasm ../node-wasm/
    rm bundle.tar.gz
    cd ../node-wasm || exit
    node app.js "$(cat ../entitlements/input.json)"
}
