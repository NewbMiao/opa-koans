#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

ENV_OS="${1:-linux}"
GO_CACHE_DIR="$workspace"/.go-cache
{
    echo "start build demo-app..."
    cd "$workspace" || exit

    GOPATH="$GO_CACHE_DIR" CGO_ENABLED=0 GOOS="$ENV_OS" GOARCH=amd64 go build -o demo-app main.go opa.go
    echo "go mod cache in:"
    echo "$GO_CACHE_DIR"
    ls "$GO_CACHE_DIR"/pkg/mod
    echo "demo-app built!"
}
