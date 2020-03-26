FROM alpine:edge

COPY . /reproducer

RUN apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    bash shfmt

WORKDIR /reproducer
ENTRYPOINT ["./test"]
