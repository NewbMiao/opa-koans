#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace" || exit
    files=()
    for file in *.rego; do
        if [[ $file != *_test.rego ]]; then
            files+=("$file")
        fi
    done
    opa build -t wasm -e entitlements "${files[@]}"
    tar -xf bundle.tar.gz "/policy.wasm"
    mv policy.wasm ../node-wasm/
    rm bundle.tar.gz
    cd ../node-wasm || exit
    node app.js "$(cat ../entitlements/input.json)"
}
