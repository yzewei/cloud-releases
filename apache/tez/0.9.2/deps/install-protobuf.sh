#!/bin/bash
  
set -o errexit
set -o nounset
set -x

version=2.5.0

download_url=https://github.com/Loongson-Cloud-Community/protobuf/releases/download/v$version/protobuf-$version.tar.gz

get_protobuf_source()
{
        pushd /tmp
        curl -OL $download_url
        tar -xf protobuf-$version.tar.gz
        rm -rf *.gz
        popd
}

install_protobuf()
{
        pushd /tmp/protobuf-$version
        ./autogen.sh
        ./configure
        make -j 4
        make install
        popd
}

get_protobuf_source

install_protobuf
