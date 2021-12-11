FROM golang:1.17 as builder

ADD . /workspace
WORKDIR /workspace

ENV GO111MODULE=on \
    GOPROXY=goproxy.cn,direct \
    CGO_ENABLED=0 \
    GOOS=linux

RUN make build


FROM scratch

EXPOSE 8080

COPY --from=builder /workspace/bin/httpserver /httpserver
ENTRYPOINT ["/httpserver"]

