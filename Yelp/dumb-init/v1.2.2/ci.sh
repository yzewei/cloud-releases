#!/bin/bash

set -o errexit
set -o nounset

git clone --branch v1.2.2 --depth=1 https://github.com/Yelp/dumb-init.git

mkdir dist

cd dumb-init

make build

cp dumb-init ../dist/dumb-init-loongarch64

