#!/usr/bin/env bash
# Use this script to test if a given TCP host/port are available
# https://docs.docker.com/compose/startup-order/
set -e

host="$1"
shift
cmd=( "$@" )
secs=5
until curl -s "$host"; do
  echo >&2 "$host is unavailable - sleeping ${secs}s"
  sleep "$secs"
done

echo >&2 "$host is up - executing command"
exec "${cmd[@]}"
