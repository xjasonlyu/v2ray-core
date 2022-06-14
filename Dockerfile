FROM golang:alpine as builder

WORKDIR /src
COPY . /src
RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 GOAMD64=v3 go build -o /v2ray -trimpath -ldflags "-s -w -buildid=" ./main

FROM v2fly/v2fly-core:latest

COPY --from=builder /v2ray /usr/bin/
