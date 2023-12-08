ORG					= apache
PROJECT			=	pulsar
VERSION			=	2.8.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/apache/pulsar.git

all: ci

env: lib
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

src/${PROJECT}:
	git clone -b v${VERSION} --depth=1 ${REPO} src/${PROJECT}

ci: src/${PROJECT}
	docker run --rm \
		-v `pwd`:/build \
		-v ${HOME}/.m2:/root/.m2/repository:rw \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build/src/'${PROJECT}'; /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
