ORG					= T_ORG
PROJECT			=	T_PROJECT
VERSION			=	T_VERSION
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/T_ORG/T_PROJECT.git

all: ci

build: lib
	docker build \
		-f Dockerfile.build \
		-t ${BUILD_IMAGE} \
		.

src/${PROJECT}:
	git clone -b ${VERSION} --depth=1 ${REPO} src/${PROJECT}

ci: src/${PROJECT}
	docker run --rm \
		-v `pwd`:/build \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build/src/'${PROJECT}'; /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
