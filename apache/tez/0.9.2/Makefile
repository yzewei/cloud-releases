ORG					= apache
PROJECT			=	tez
VERSION			=	0.9.2
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/tez.git

LOCAL_REPO ?= ${HOME}/.m2/repository

all: ci

build: 
	docker build \
		-f Dockerfile.build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		-t ${BUILD_IMAGE} \
		.

src/${PROJECT}:
	git clone -b loongarch64-${VERSION} --depth=1 ${REPO} src/${PROJECT}

ci: src/${PROJECT}
	docker run --rm \
		-v `pwd`:/build \
		-v ${LOCAL_REPO}:/root/.m2/repository:rw \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} \
		/bin/bash -c 'cd /build/src/'${PROJECT}'; /build/ci.sh'

