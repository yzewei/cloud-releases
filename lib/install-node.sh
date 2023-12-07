#!/bin/bash

set -o nounset
set -o errexit

NODE_VERSION=

NODE_VERSION_LIST=(
  10.24.1
  12.19.1
  12.22.12
  14.16.1
  14.21.3
  16.3.0
  16.5.0
  16.17.1
  16.20.1
  18.13.0
  )

install_node()
{
  pushd /tmp

  curl -OL http://ftp.loongnix.cn/nodejs/LoongArch/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-loong64.tar.gz
  tar -xf node* && rm -rf *.gz
  mv node* node
  cp -Rf node/. /usr/
  popd
}

install_loongson_npm()
{
  echo "registry =https://registry.loongnix.cn:4873" >> ~/.npmrc
}
NODE_VERSION=$1

install_node
install_loongson_npm
