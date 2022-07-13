FROM golang:1.18.4-alpine as build
RUN apk update && apk upgrade && \
    apk add --no-cache git
RUN go get -u golang.org/x/perf/cmd/benchstat

FROM gcr.io/distroless/base-debian10
COPY --from=build /go/bin/benchstat /
ENTRYPOINT ["/benchstat"]