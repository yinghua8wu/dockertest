FROM alpine:3.12

RUN apk update && \
    apk add wget && \
    cd /root && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/fcn_x64_musl && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/gost-linux-amd64 && \
    wget https://raw.githubusercontent.com/yinghua8wu/tcpudp/master/fcn-o.conf && \
    wget https://raw.githubusercontent.com/yinghua8wu/dockertest/master/entry.sh && \
    mv fcn_x64_musl fcn && \
    mv gost-linux-amd64 gost && \
    chmod +x fcn gost entry.sh

ENTRYPOINT ["/root/entry.sh"]
