ORG					= bpftrace
PROJECT			=	bpftrace
VERSION			=	0.20.3
BUILD_IMAGE	= ${PROJECT}-build:${VERSION}

REPO				=	https://github.com/bpftrace/bpftrace.git

all: ci

env: lib
	docker build \
                -f Dockerfile.build \
                -t ${BUILD_IMAGE} \
                .

src/${PROJECT}: clean 
	git clone -b v$(VERSION) --depth 1 $(REPO) && \
	git clone -b v1.3.0 --depth 1 https://github.com/libbpf/libbpf.git

ci: src/${PROJECT}
	docker run --rm -v `pwd`:/build \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		-e TAG=${ORG}/${PROJECT} \
		-e VERSION=${VERSION} \
		-e PROJECT=${PROJECT} \
		${BUILD_IMAGE} /bin/bash -c 'cd /build/'$(PROJECT)'; /build/ci.sh'


.PHONY: lib
lib:
	rm -rf lib
	cp -R ../../../lib lib
clean:
	sudo rm -rf $(PROJECT) libbpf
