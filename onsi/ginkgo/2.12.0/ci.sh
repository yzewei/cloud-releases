#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

echo "set go env"
	go env -w GOFLAGS="-buildvcs=false"
#	export GOPROXY=https://goproxy.cn

echo "start build--------------------------------"
	cd /build/$PROJECT && \
		go build ./ginkgo/main.go && \
		mkdir bin && mv main bin/ginkgo
		tar zcvf $PROJECT-linux-loong64.tar.gz bin && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

