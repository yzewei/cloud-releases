#!/bin/bash

set -o errexit
set -o nounset


echo "start build--------------------------------"

# 判断 deps/jemalloc/build-aux/ 是否存在
if [ ! -d "/build/redis/deps/jemalloc/build-aux" ]; then
    echo "Directory deps/jemalloc/build-aux does not exist, skipping wget commands."
    sed -i 's/-Wall/-Wall -lm/g' /build/redis/Makefile
else
    # 如果目录存在，执行 wget 下载命令
    wget https://git.savannah.gnu.org/cgit/config.git/plain/config.guess -O deps/jemalloc/build-aux/config.guess
    wget https://git.savannah.gnu.org/cgit/config.git/plain/config.sub -O deps/jemalloc/build-aux/config.sub
fi

# 继续后续的构建操作
cd /build/redis && \
#    make && mkdir redis-bin/ && cp src/redis-server redis-bin/ && cp src/redis-cli redis-bin/ && cp redis.conf redis-bin/ && tar zcvf redis-6.2.8.tar.gz redis-bin/ && \
    make && cd ../ && tar zcvf redis-6.2.8.tar.gz /build/redis && \
    bash /build/lib/curl.sh /build/redis-6.2.8.tar.gz redis/redis 6.2.8
