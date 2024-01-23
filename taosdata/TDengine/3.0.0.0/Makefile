ORG					= taosdata
PROJECT			=	tdengine
VERSION			=	3.0.0.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/TDengine.git

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
		/bin/bash -c 'cd /build && /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib

clean:
	rm -rf TDengine dist
