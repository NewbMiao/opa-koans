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
    mv policy.wasm ../node-wasm/
    rm bundle.tar.gz
    cd ../node-wasm || exit
    node app.js "$bundleDir/input.json" "$bundleDir/data.json"
}
