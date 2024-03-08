# Entitlements demo

Demo to show how to build policy with decoupling rules (data) and policy

Details in [here](https://slides.com/newbmiao/building-api-with-opa)

## use opa cli

```sh
cd entitlemnts
# run
opa eval -f values -b . -i input.json "data.entitlements.main"
# profile peformance
opa eval --profile -f pretty -b . -i input.json "data.entitlements.main"

# test with coverage
opa test . -c --threshold 100 -b 

# test with ensure coverage 100%, fail if not
opa test . -c --threshold 100 -b -v
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