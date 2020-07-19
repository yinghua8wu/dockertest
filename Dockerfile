FROM alpine:3.12

RUN apk update && \
    apk add wget && \
    cd /root && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/fcn_x64_musl && \
    wget https://github.com/yinghua8wu/tcpudp/raw/master/gost-linux-amd64 && \
    wget https://raw.githubusercontent.com/yinghua8wu/tcpudp/master/fcn-o.conf && \
    mv fcn_x64_musl fcn && \
    mv gost-linux-amd64 gost && \
    chmod +x fcn gost
	
EXPOSE 80

CMD ["/root/fcn", "--cfg", "fcn-o.conf" && "/root/gost", "-L=socks5://:11080?dns=8.8.4.4:853/tls,208.67.220.220:5353/udp,208.67.220.220:443/tcp"]
