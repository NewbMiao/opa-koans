#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
{
    cd "$workspace" || exit
    bundleDir="$workspace"/../entitlements
    cd "$bundleDir" || exit
    sh build.sh wasm
    echo "entitlements policy files bundled!"

    mv data.json "$workspace"
    rm bundle.tar.gz
    cd "$workspace" || exit
    docker build -t node-api .
}
