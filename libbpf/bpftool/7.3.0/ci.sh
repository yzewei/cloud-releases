#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh

	export https_proxy="http://10.130.0.20:7890"

echo "start build--------------------------------"
		cd /build/$PROJECT/src && \
		make && \
		tar zcvf $PROJECT-linux-loong64.tar.gz  bpftool && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

