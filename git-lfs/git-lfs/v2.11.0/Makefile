ORG				= git-lfs
PROJECT			=git-lfs
VERSION			=v2.11.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO			=https://github.com/Loongson-Cloud-Community/git-lfs.git

all: ci

env: 
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

ci: 
	docker run --rm \
		-v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build && ./ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib

clean:
	rm -rf dist git-lfs
