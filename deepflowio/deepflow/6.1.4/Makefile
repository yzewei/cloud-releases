ORG					= deepflowio
PROJECT			=	deepflow
VERSION			=	6.1.4
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/deepflow.git

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: 
	git clone -b loong64-6.1.4 --depth 1 $(REPO)

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxt} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/src/'$(PROJECT)'; /build/ci.sh'


.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib

