#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

CUR_OS=$(uname | tr LD ld)
ENV_OS="${1:-$CUR_OS}"
GO_CACHE_DIR="$workspace"/.go-cache
bundleDir="$workspace"/../..

opa_bundle() {
    REVISION_BUNDLE=$(git log --abbrev-commit --pretty=format:"%h" "$bundleDir"/example | head -n1)
    REVISION_DISCOVERY=$(git log --abbrev-commit --pretty=format:"%h" "$bundleDir"/discovery | head -n1)
    cat >"$workspace"/revision.env <<EOF
# demo-server env_file: revision of each bundle, used for etag
REVISION_BUNDLE=$REVISION_BUNDLE
REVISION_DISCOVERY=$REVISION_DISCOVERY
EOF
    dockerComposeDir="$workspace"/..
    cd "$bundleDir" || exit
    # enable partical evaluation optimize for bundle build
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b example -o rbac.tar.gz -t rego -O 1 -e rbac/allow -r "$REVISION_BUNDLE"
    echo "RBAC files bundled!"

    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b discovery -o discovery.tar.gz -t rego
    mv rbac.tar.gz discovery.tar.gz "$dockerComposeDir/demo-server"
    echo "Discovery files bundled!"
}

{
    echo "start build opa bundle ..."
    opa_bundle
    echo "start build demo-app ..."
    cd "$workspace" || exit

    export GOPROXY=https://goproxy.cn,direct
    GOPATH="$GO_CACHE_DIR" CGO_ENABLED=0 GOOS="$ENV_OS" GOARCH=amd64 go build -ldflags="-s -w" -o demo-app main.go opa.go
    echo "go mod cache in .go-cache:"
    ls "$GO_CACHE_DIR"/pkg/mod
    echo "demo-app built!"
}
