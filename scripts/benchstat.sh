#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

{
    cd "$workspace/../bundle"
    docker run --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b example -o rbac-raw.tar.gz -t rego
    echo "rbac files bundled!"
    docker run --rm -v "$(pwd)":/code -w /code openpolicyagent/opa:latest build -b example -o rbac-optmized.tar.gz -O 1 -e rbac/allow -t rego
    echo "rbac files bundled with optmization!"

    cnt=1
    opa bench -f gobench -b rbac-raw.tar.gz --count "$cnt" -i "$workspace/../quick-start/input.json" --benchmem 'data.rbac.allow' >rbac-raw.txt
    opa bench -f gobench -b rbac-optmized.tar.gz --count "$cnt" -i "$workspace/../quick-start/input.json" --benchmem 'data.rbac.allow' >rbac-optmized.txt
    go install golang.org/x/perf/cmd/benchstat
    benchstat rbac-raw.txt rbac-optmized.txt | tee bench.txt
    rm rbac-*.txt rbac-*.tar.gz
}
