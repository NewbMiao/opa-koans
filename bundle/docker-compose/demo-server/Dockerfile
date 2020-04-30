FROM golang:1.14.2-alpine

ADD . /code
WORKDIR /code
EXPOSE 8888
RUN apk update && apk upgrade && \
    apk add --no-cache git jq
RUN sh /code/build.sh linux
ENTRYPOINT [ "/code/demo-app"]