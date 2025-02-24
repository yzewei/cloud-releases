ORG          = redis
PROJECT      = redis
VERSION      = 6.2.8
BUILD_IMAGE  = ${PROJECT}-build:${VERSION}
REGISTRY     = lcr.loongnix.cn/cache
REPO         = https://github.com/redis/redis
REMOTE_SHA=?
all: ci

env: lib
	@if docker pull ${REGISTRY}/${BUILD_IMAGE}; then \
                REMOTE_SHA=$(docker pull ${REGISTRY}/${BUILD_IMAGE} 2>/dev/null | grep "Digest" | awk '{print $2}'); \
                LOCAL_SHA=$(docker images --digests ${REGISTRY}/${BUILD_IMAGE} | awk 'NR==2 {print $3}'); \
                if [ "$REMOTE_SHA" != "$LOCAL_SHA" ]; then \
                        echo "SHA mismatch! Pushing the local image to remote registry..."; \
                        docker build \
                        --build-arg https_proxy=$(https_proxy) \
                        -f Dockerfile.build \
                        -t ${REGISTRY}/${BUILD_IMAGE} \
                        . && \
                        docker push ${REGISTRY}/${BUILD_IMAGE}; \
                else \
                        echo "Image ${REGISTRY}/${BUILD_IMAGE} exists. Pulled successfully."; \
                fi; \
        else \
                echo "Image ${REGISTRY}/${BUILD_IMAGE} not found. Building and pushing..."; \
                docker build \
                        --build-arg https_proxy=$(https_proxy) \
                        -f Dockerfile.build \
                        -t ${REGISTRY}/${BUILD_IMAGE} \
                        . && \
                docker push ${REGISTRY}/${BUILD_IMAGE}; \
        fi

src/${PROJECT}: clean
	git clone --depth 1 -b ${VERSION} ${REPO}

ci: src/${PROJECT}
	echo $(CURDIR)
	docker run --rm -v $(CURDIR):/build \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e https_proxy=${https_proxy} \
		-e http_proxy=${http_proxy} \
		${REGISTRY}/${BUILD_IMAGE} /bin/bash -c 'cd /build/$(PROJECT); /build/ci.sh'

.PHONY: lib
lib:
	rm -rf lib
	cp -r ../../../lib lib

clean:
	rm -rf v* $(PROJECT)
