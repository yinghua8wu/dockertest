FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash curl wget
WORKDIR /go/src/v2ray.com/core
RUN git clone --progress https://github.com/v2fly/v2ray-core.git . && \
    bash ./release/user-package.sh nosource noconf codename=$(git describe --tags) buildname=docker-fly abpathtgz=/tmp/v2ray.tgz && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/fcn_x64_musl && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/gost-linux-amd64 && \
    wget https://raw.githubusercontent.com/yinghua8wu/tcpudp/master/fcn-o.conf && \
    mv fcn_x64_musl fcn && \
    mv gost-linux-amd64 gost && \
    chmod +x fcn gost

FROM alpine
ENV CONFIG=https://raw.githubusercontent.com/yeahwu/kinto/master/config.json
COPY --from=builder /tmp/v2ray.tgz /tmp
RUN apk update && apk add --no-cache tor ca-certificates && \
    tar xvfz /tmp/v2ray.tgz -C /usr/bin && \
    rm -rf /tmp/v2ray.tgz
    
CMD nohup tor & \
    ./fcn --cfg fcn-o.conf \
    nohup ./gost -L=ss+kcp://chacha20:kintopw@:11080?dns=8.8.4.4:853/tls,1.0.0.1:853/tls >gost.log 2>&1 & \
    v2ray -config $CONFIG
