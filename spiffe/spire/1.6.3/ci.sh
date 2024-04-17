#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh

echo "set goproxy"
export GOPROXY=https://goproxy.cn
go env -w GOFLAGS="-buildvcs=false"
export CFLAGS="-D_LARGEFILE64_SOURCE"
echo "start build--------------------------------"
	cd /build/spire && \
       		make build-static && \
		cp bin/static/spire-server spire-server && \
		cp bin/static/spire-agent spire-agent && \
		tar zcvf spire-server-linux-loong64.tar.gz spire-server && \
		tar zcvf spire-agent-linux-loong64.tar.gz spire-agent && \
		bash /build/lib/curl.sh spire-server-linux-loong64.tar.gz spiffe/spire 1.6.3 && bash /build/lib/curl.sh spire-agent-linux-loong64.tar.gz spiffe/spire 1.6.3
