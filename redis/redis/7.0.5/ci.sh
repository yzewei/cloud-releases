#!/bin/bash

set -o errexit
set -o nounset

bash /build/lib/set-ftp.sh

echo "start build--------------------------------"
	cd /build/${PROJECT}/deps && make jemalloc && \
	cd /build/${PROJECT}/  && make && \
		tar zcvf ${PROJECT}-linux-loong64.tar.gz ./* && \
		bash /build/lib/curl.sh ${PROJECT}-linux-loong64.tar.gz ${ORG}/${PROJECT} ${VERSION}
