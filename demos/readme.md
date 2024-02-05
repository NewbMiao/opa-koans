# Entitlements demo

Demo to show how to build policy with decoupling rules (data) and policy

## use opa cli

```sh
# run
opa eval -f values -d . -i input.json "data.entitlements.main"
# profile peformance
opa eval --profile -f pretty -d . -i input.json "data.entitlements.main"

# test with coverage
opa test . -c --threshold 100

# test with ensure coverage 100%, fail if not
opa test . -c --threshold 100 -v
# test with bench
opa test -v --bench --count 1 .
```

## use wasm

```sh
sh entitlements/build.sh
```
