#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

{
    cd "$workspace"/../ || exit
    echo "Verify wasm..."
    res=$(sh wasm/run.sh "$(cat quick-start/input.json)")
    echo "Opa wasm responses: $res"
    verified=$(echo "$res" | grep -c "true")
    if [ "$verified" = "1" ]; then
        echo "opa wasm verified!"
    else
        echo "opa wasm Not verified!"
        exit 1
    fi
}
