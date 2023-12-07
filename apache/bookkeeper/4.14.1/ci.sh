#!/bin/bash

set -o errexit
set -o nounset

git apply ../../bookkeeper-4.14.1.patch
mvn clean package -P loongarch64-linux-nar-aol -DskipTests
