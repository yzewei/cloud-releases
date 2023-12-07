ORG					= apache
PROJECT			=	kafka
VERSION			=	2.5.0
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/kafka.git

all: ci

env: lib
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

src/${PROJECT}:
	git clone -b loongarch64-${VERSION} --depth=1 ${REPO} src/${PROJECT}

ci: src/${PROJECT}
	docker run --rm \
		-v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build/src/'${PROJECT}'; /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
