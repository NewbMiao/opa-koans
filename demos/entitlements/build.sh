#!/usr/bin/env bash
set -eu
workspace=$(cd "$(dirname "$0")" && pwd -P)
bundleType="${1:-wasm}"
echo "bundleType: $bundleType"
{
    cd "$workspace" || exit
    find . -type f -name '*.yaml' -print0 | xargs -0 cat >rules.yaml
    combined_json=$(yq eval-all '. | tojson' rules.yaml)
    echo "{\"rules\": $combined_json}" > data.json

    opa build -b . -t "${bundleType}" -e "entitlements/main" --optimize=1
    echo "Bundle created successfully"
    rm -f rules.yaml
    echo "Cleaned up temp files: rules.yaml"
}
