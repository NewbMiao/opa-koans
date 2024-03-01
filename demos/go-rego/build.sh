#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

CUR_OS=$(uname | tr LD ld)
ENV_OS="${1:-$CUR_OS}"
GO_CACHE_DIR="$workspace"/.go-cache
{
    echo "start build opa bundle ..."
    bundleDir="$workspace"/../entitlements
    cd "$bundleDir" || exit

    sh build.sh rego
    echo "entitlements policy files bundled!"
    mv bundle.tar.gz ../go-rego/
    echo "start build go-rego ..."
    cd "$workspace" || exit

    # export GOPROXY=https://goproxy.cn,direct
    # GOPATH="$GO_CACHE_DIR" CGO_ENABLED=0 GOOS="$ENV_OS" GOARCH=amd64 go build -ldflags="-s -w" -o go-rego main.go opa.go
    # echo "go mod cache in .go-cache:"
    # ls "$GO_CACHE_DIR"/pkg/mod
    # echo "start serve go-rego ..."
    # go run .
    docker build -t go-rego .

}
