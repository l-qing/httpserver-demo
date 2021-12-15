.PHONY: default
default: help

##@ General

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Development
export GIT_COMMIT = $(shell git rev-parse HEAD)
export BUILD_TIME = $(shell date)
IMAGE?=httpserver
IMAGE_TAG?=latest

.PHONY: build run test
build: ## build binary
	@echo "building httpserver binary"
	@mkdir -p bin
	CGO_ENABLED=0 go build -ldflags '-X "main.buildTime=$(BUILD_TIME)" -X "main.commitID=$(GIT_COMMIT)"' -o bin/httpserver .

run: ## run httpserver
	./bin/httpserver

test: ## test use curl
	curl http://localhost:8080/hello?user=world

build-image: ## build image
	docker build -t $(IMAGE):$(IMAGE_TAG) ./

push-image: build-image ## push image
	docker push $(IMAGE):$(IMAGE_TAG)

run-image: ## run image
	docker run --rm -it --name httpserver -p 8080:8080 $(IMAGE):$(IMAGE_TAG)


TOOLS_IMAGE?=tools
TOOLS_IMAGE_TAG?=latest
build-tools-image:
	docker build -f Dockerfile.tools -t ${TOOLS_IMAGE}:${TOOLS_IMAGE_TAG} ./
push-tools-image:
	docker push ${TOOLS_IMAGE}:${TOOLS_IMAGE_TAG}

