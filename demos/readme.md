# Entitlements demo

Demo to show how to build policy with decoupling rules (data) and policy

## use opa cli

```sh
cd entitlemnts
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

# use bundle in opa

```sh
cd entitlemnts
sh build.sh rego
opa run bundler.tar.gz
```

## use wasm in node 

```sh
sh node-wasm/build.sh
```


## use wasm in node api

```sh
cd node-wasm-api
sh build.sh
docker run -it -p 3001:3001 node-wasm-api

# cargo install drill 
drill --benchmark benchmark.yml --stats
```

## use rego in go api

```sh
cd go-rego
sh build.sh
docker run -it -p 8888:8888 go-rego

# cargo install drill 
drill --benchmark benchmark.yml --stats
```