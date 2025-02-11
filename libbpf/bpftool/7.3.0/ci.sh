#!/bin/bash

set -o errexit
set -o nounset



echo "start build--------------------------------"
		cd /build/$PROJECT/src && \
		make && \
		tar zcvf $PROJECT-linux-loong64.tar.gz  bpftool && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

