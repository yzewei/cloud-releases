#!/bin/bash

set -o errexit
set -o nounset

bash /lib/set-ftp.sh


echo "start build--------------------------------"
	cd /build/libbpf && cd src && make install_uapi_headers
	cd /build/$PROJECT && \
		#git apply ../0001-add-static.patch && \
		mkdir build && cd build && \
		cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF ../ && \
		make -j8 && cd /build/$PROJECT/build/src && \
		tar zcvf $PROJECT-linux-loong64.tar.gz  bpftrace && \
		bash /build/lib/curl.sh *-linux-loong64.tar.gz $TAG $VERSION 

