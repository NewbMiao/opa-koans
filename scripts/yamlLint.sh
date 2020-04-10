workspace=$(cd $(dirname $0) && pwd -P)
{
    cd $workspace/../
    echo "Yaml Linting"
    docker run --rm -v $(pwd):/workdir giantswarm/yamllint -d "{extends: relaxed, rules: {line-length: {max: 120}}}" $(find . -type f -name '*.yaml' -or -name '*.yml' ! -path '*/.github/*')
}
