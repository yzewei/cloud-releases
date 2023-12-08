#!/bin/bash

set -o errexit
set -o nounset

#git apply --whitespace=nowarn ../../ambari_0001-add-loong64-support.patch
#patch -d ../ambari -p1 < ../../update_download.patch

mvn -B clean install package rpm:rpm -Drat.skip=true -DnewVersion=2.7.0.0.0 -DbuildNumber=631319b00937a8d04667d93714241d2a0cb17275 -DskipTests -Dpython.ver="python >= 2.6" ||
cd /build/src/ambari/ambari-metrics && mvn package install -Dbuild-rpm -DskipTests || 
cd /build/src/ambari/ambari-logsearch && mvn versions:set -DnewVersion=2.7.0.0.0 && mvn clean install package -P native,rpm -DskipTest ;
cd /build/src/ambari/ambari-infra && mvn versions:set -DnewVersion=2.7.0.0.0 &&mvn clean package install -P rpm -DskipTest -Drat.skip=true 
