#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh

echo "set goproxy"
export GOPROXY=https://goproxy.cn
go env -w GOFLAGS="-buildvcs=false"
export CFLAGS="-D_LARGEFILE64_SOURCE"
echo "start build--------------------------------"
	cd /build/ekuiper && \
       		make && \
		tar zcvf ekuiper-linux-loong64.tar.gz _build/kuiper-* && \
		bash /build/lib/curl.sh ekuiper-linux-loong64.tar.gz lf-edge/ekuiper 1.6.3
