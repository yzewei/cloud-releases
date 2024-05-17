#!/bin/bash

rm /etc/yum.repos.d/AnolisOS.repo
touch /etc/yum.repos.d/AnolisOS.repo
echo -e "[os]\nname=AnolisOS-$releasever - os\nbaseurl=https://build.openanolis.cn/kojifiles/output/anolis-23-20240128.3/compose/os/loongarch64/os/\nenabled=1\ngpgcheck=0" | tee -a /etc/yum.repos.d/AnolisOS.repo > /dev/null
