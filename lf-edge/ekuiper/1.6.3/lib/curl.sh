#!/bin/bash
# example: bash curl.sh deepflow.tgz deepflowio/deepflow 6.1.4
# example: bash curl.sh *-linux-loong64.tar.gz $TAG $VERSION
curl -F file=@$1 cloud.loongnix.xa/releases/loongarch64/$2/$3
