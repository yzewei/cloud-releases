#!/bin/bash

set -o errexit
set -o nounset

bash lib/set-ftp.sh

git clone --branch v1.2.2 --depth=1 https://github.com/Yelp/dumb-init.git

mkdir dist

cd dumb-init

make build

cp dumb-init ../dist/dumb-init-loongarch64

tar zcvf dumb-init-linux-loong64.tar.gz dumb-init && \
                bash /build/lib/curl.sh dumb-init-linux-loong64.tar.gz Yelp/dumb-init 1.2.2 
