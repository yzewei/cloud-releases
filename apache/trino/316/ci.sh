#!/bin/bash

set -o errexit
set -o nounset

add_supplementary_repo()
{
    pushd /tmp

    curl -OL https://github.com/Loongson-Cloud-Community/trino/releases/download/316/maven_supplementary_repo.tar.gz

    mkdir -p /root/.m2/repository
    tar --extract \
	--file maven_supplementary_repo.tar.gz \
	--directory "/root/.m2/repository" \
	--strip-components 1 \
	--no-same-owner

    rm -rf maven_supplementary_repo.tar.gz

    popd
}

add_supplementary_repo

./mvnw clean package -DskipTests
