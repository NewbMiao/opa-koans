#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace" || exit
    bundleDir="$workspace"/../entitlements
    cd "$bundleDir" || exit
    sh build.sh wasm
    echo "entitlements policy files bundled!"

    tar -xf bundle.tar.gz "/policy.wasm"
    mv policy.wasm data.json "$workspace"
    rm bundle.tar.gz
    cd "$workspace" || exit
    docker build -t node-wasm-api .
}
