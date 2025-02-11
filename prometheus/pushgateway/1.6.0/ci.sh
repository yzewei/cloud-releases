#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn

echo "start build--------------------------------"
	cd /build/pushgateway && \
       	 go build -mod=vendor -o pushgateway ./main.go && \
		tar zcvf pushgateway-linux-loong64.tar.gz pushgateway && \
		bash /build/lib/curl.sh pushgateway-linux-loong64.tar.gz prometheus/pushgateway 1.6.0
