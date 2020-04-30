#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

CUR_OS=$(uname | tr LD ld)
ENV_OS="${1:-$CUR_OS}"
GO_CACHE_DIR="$workspace"/.go-cache

{
    export GOPROXY=https://goproxy.cn,direct
    GOPATH="$GO_CACHE_DIR" CGO_ENABLED=0 GOOS="$ENV_OS" GOARCH=amd64 go build -o demo-app main.go opa.go
    echo "go mod cache in .go-cache:"
    ls "$GO_CACHE_DIR"/pkg/mod
    echo "demo-app built!"
}
