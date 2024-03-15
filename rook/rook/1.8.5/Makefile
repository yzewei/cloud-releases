ORG					= rook
PROJECT			=	rook
VERSION			=	1.8.5
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/Loongson-Cloud-Community/rook

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: 
	git clone -b loong64-1.8.5 --depth 1 $(REPO)

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/'$(PROJECT)'; /build/ci.sh'


.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
clean:
	rm -rf rook
