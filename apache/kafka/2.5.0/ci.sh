#!/bin/bash

set -o errexit
set -o nounset


# product
./gradlew clean releaseTarGz

# development
#./gradlew clean releaseTarGz --info

# note
# 2023.12.07 从 loongson maven 仓库下载 scala-compiler 2.12.10 导致编译失败
