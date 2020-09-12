#!/bin/sh
cd /root
./fcn --cfg fcn-o.conf
nohup ./gost -L=http://:3000 >g.log 2>&1 &
nohup ./gost -L=ss+kcp://chacha20:kintopw@:11080?dns=8.8.4.4:853/tls,1.0.0.1:853/tls >gost.log 2>&1 &
tail -f /dev/null
