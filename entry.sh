#!/bin/sh
cd /root
./fcn --cfg fcn-o.conf
./gost -L=socks5://:11080?dns=8.8.4.4:853/tls,208.67.220.220:5353/udp,208.67.220.220:443/tcp
