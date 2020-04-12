FROM golang:1.14.2-alpine

ADD . /code
WORKDIR /code
ENV GOPROXY=https://goproxy.cn,direct
RUN GO111MODULE=on go mod download
RUN go build -o demo-app main.go opa.go
ENTRYPOINT [ "/code/demo-app"] 