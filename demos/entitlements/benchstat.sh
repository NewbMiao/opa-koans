#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

{
    echo "start build opa bundle ... # format: rego"
    cd "$workspace" || exit
    opa  build -b . -o entitlements-raw.tar.gz -t rego
    echo "entitlements files bundled!"
    opa  build -b . -o entitlements-optmized.tar.gz -O 1 -e entitlements/main -t rego
    echo "entitlements files bundled with optmization!"

    cnt=5 # https://github.com/golang/go/issues/23471
    echo "benchmark orignal entitlements bundle..."
    opa bench -f gobench -b entitlements-raw.tar.gz --count "$cnt" -i input.json --benchmem 'data.entitlements.main' > entitlements-raw.txt
    echo "benchmark optmized entitlements bundle..."
    opa  bench -f gobench -b entitlements-optmized.tar.gz --count "$cnt" -i input.json --benchmem 'data.entitlements.main' > entitlements-optmized.txt
    echo "use benchstat to compare them:"
    docker run --platform linux/amd64 --rm -v "$(pwd)":/code -w /code newbmiao/benchstat:v1 entitlements-raw.txt entitlements-optmized.txt | tee bench.txt
    rm entitlements-*.txt entitlements-*.tar.gz
}
