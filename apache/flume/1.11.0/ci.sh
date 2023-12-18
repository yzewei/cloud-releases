#!/bin/bash

set -o errexit
set -o nounset

get_host(){
    ip_address=$(echo $http_proxy | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
    echo $ip_address
}

get_port(){
    port=$(echo $http_proxy | grep -oE ":[0-9]+" | sed 's/://')
    echo $port
}

mvn_conf(){
    cp loongson-maven.template settings.xml
    sed -i "s/proxy_host/$1/g" settings.xml
    sed -i "s/proxy_port/$2/g" settings.xml
    cp -f settings.xml ~/.m2/settings.xml
}

if [ -n "$http_proxy" ]; then
    echo "http_proxy=$http_proxy"
else
    echo "http_proxy not exist, please set"
    exit 1
fi

proxy_host=$(get_host)
proxy_port=$(get_port)

mvn_conf $proxy_host $proxy_port

cd src/flume && mvn clean install -DskipTests -Dspotbugs.skip=true
