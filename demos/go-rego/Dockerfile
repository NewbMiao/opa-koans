FROM golang:1.22.3-alpine as base

ENV GOPROXY https://goproxy.cn,direct
WORKDIR /code
COPY go.mod go.sum /code
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o go-rego main.go opa.go

FROM scratch

COPY --from=base /code/go-rego .
COPY --from=base /code/bundle.tar.gz .
EXPOSE 8888
CMD ["./go-rego"]
