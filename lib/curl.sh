#!/bin/bash
# example: bash curl.sh deepflow.tgz deepflowio/deepflow 6.1.4
curl -F file=@$1 cloud.loongnix.cn/$2/$3
