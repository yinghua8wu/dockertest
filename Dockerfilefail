FROM alpine:3.12

RUN apk update && \
    apk add wget && \
    cd /root && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/fcn_x64_musl && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/gost-linux-amd64 && \
    wget https://raw.githubusercontent.com/yinghua8wu/tcpudp/master/fcn-o.conf && \
    wget https://github.com/yinghua8wu/dockertest/raw/master/chfs && \
    mv fcn_x64_musl fcn && \
    mv gost-linux-amd64 gost && \
    chmod +x fcn gost chfs

CMD cd /root \
    ./fcn --cfg fcn-o.conf \
    nohup ./chfs --path="/root/" --port=3000 >chfs.log 2>&1 & \
    nohup ./gost -L=ss+kcp://chacha20:kintopw@:11080?dns=8.8.4.4:853/tls,1.0.0.1:853/tls >gost.log 2>&1 & \
    tail -f /dev/null \
