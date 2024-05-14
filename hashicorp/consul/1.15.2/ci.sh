#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh

echo "set goproxy"
export GOPROXY=https://goproxy.cn
go env -w GOFLAGS="-buildvcs=false"
export CFLAGS="-D_LARGEFILE64_SOURCE"
echo "start build--------------------------------"
	cd /build/${PROJECT} && \
       		make linux && \
		tar zcvf ${PROJECT}-linux-loong64.tar.gz pkg/bin/linux_loong64 && \
		bash /build/lib/curl.sh ${PROJECT}-linux-loong64.tar.gz ${ORG}/${PROJECT} ${VERSION}
