#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

{
    cd "$workspace/../bundle"
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b example -o rbac-raw.tar.gz -t rego
    echo "rbac files bundled!"
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b example -o rbac-optmized.tar.gz -O 1 -e rbac/allow -t rego
    echo "rbac files bundled with optmization!"

    cnt=5 # https://github.com/golang/go/issues/23471
    cp "$workspace/../quick-start/input.json" rbac-input.json
    echo "benchmark orignal rbac bundle..."
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest bench -f gobench -b rbac-raw.tar.gz --count "$cnt" -i rbac-input.json --benchmem 'data.rbac.allow' >rbac-raw.txt
    echo "benchmark optmized rbac bundle..."
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest bench -f gobench -b rbac-optmized.tar.gz --count "$cnt" -i rbac-input.json --benchmem 'data.rbac.allow' >rbac-optmized.txt
    echo "use benchstat to compare them:"
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code newbmiao/benchstat:v1 rbac-raw.txt rbac-optmized.txt | tee bench.txt
    rm rbac-*.txt rbac-*.json rbac-*.tar.gz
}
