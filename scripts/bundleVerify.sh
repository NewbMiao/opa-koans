#!/usr/bin/env bash
set -e
workspace=$(cd "$(dirname "$0")" && pwd -P)

opa_verify() {
    res=$(sh start.sh opa-ping 10)
    echo "Opa ping responses: $res"
    verified=$(echo "$res" | grep -c "true")
    if [ "$verified" = "3" ]; then
        echo "demo-server, opa-bundle and opa-discovery verified!"
    else
        echo "demo-server, opa-bundle and opa-discovery Not verified!"
        exit 1
    fi
}
{
    cd "$workspace"/../bundle || exit
    echo "Verify slim version of bundle server monitor..."
    sh start.sh start
    opa_verify
    sh start.sh stop

    echo "Verify advance version of bundle server monitor..."
    sh start.sh start-advance
    opa_verify
    sh start.sh stop-advance
}
