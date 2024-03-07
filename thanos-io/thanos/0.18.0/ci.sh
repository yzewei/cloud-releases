#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set goproxy"
	export GOPROXY=https://goproxy.cn
	go env -w GOFLAGS="-buildvcs=false"
echo "download promu"
	wget http://cloud.loongnix.xa/prometheus%2Fpromu%2F0.15.0%2Fpromu-0.15.0_Linux-Loong64.tar.gz -O promu.tar.gz && \
		tar xf promu.tar.gz && mv promu /usr/bin

echo "start build--------------------------------"
	cd /build/thanos && \
		go get -u golang.org/x/sys/unix && \
		go get -u golang.org/x/net/internal/socket && \
		go mod tidy && \
	 	promu build --prefix /build/thanos  && tar zcvf thanos-linux-loong64.tar.gz thanos && \
       	bash /build/lib/curl.sh thanos-linux-loong64.tar.gz thanos-io/thanos 0.18.0
