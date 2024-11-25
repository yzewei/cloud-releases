#!/bin/bash
# example: bash curl.sh deepflow.tgz deepflowio/deepflow 6.1.4
#chmod +w /etc/hosts
#sed -i '/cloud.loongnix.xa/d' "/etc/hosts"
#echo "10.130.0.141 cloud.loongnix.xa" >> "/etc/hosts"
#curl -F file=@$1 10.130.0.141/$2/$3
unset http_proxy
curl --resolve cloud.loongnix.xa:80:10.130.0.141 -F file=@$1 cloud.loongnix.xa/releases/loongarch64/$2/$3
