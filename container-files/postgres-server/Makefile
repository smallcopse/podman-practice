# container image name
IMAGE_NAME := postgresql
# make params
MAKEFLAGS = -j 4
# container params
CONTAINER_RUNTIME = podman
BUILD_ARGS := --rm
REBUILD_ARGS := --no-cache --squash --rm
RUN_ARGS := --rm -it
RUN_CMD := bash
START_ARGS := -e "POSTGRES_PASSWORD=123" -e "POSTGRES_HOST_AUTH_METHOD=scram-sha-256" -e "POSTGRES_INITDB_ARGS=--auth-host=scram-sha-256"
USER_NAME := $(shell whoami)
REGISTRY := registry.local
TAG := 16
IMAGE_TAG := $(REGISTRY)/$(USER_NAME)/$(IMAGE_NAME):$(TAG)

.PHONY: build
build: Containerfile docker-entrypoint.sh
	$(CONTAINER_RUNTIME) build $(BUILD_ARGS) -t $(IMAGE_TAG) -f Containerfile .

.PHONY: rebuild
rebuild: Containerfile docker-entrypoint.sh
	$(CONTAINER_RUNTIME) build $(REBUILD_ARGS) -t $(IMAGE_TAG) -f Containerfile .

.PHONY: run
run:
	$(CONTAINER_RUNTIME) run $(RUN_ARGS) $(IMAGE_TAG) $(RUN_CMD)

.PHONY: start
start:
	$(CONTAINER_RUNTIME) run $(START_ARGS) -d --name $(IMAGE_NAME) $(IMAGE_TAG)

.PHONY: stop
stop:
	$(CONTAINER_RUNTIME) rm -f $(IMAGE_NAME)

.PHONY: restart
restart: stop start

.PHONY: exec
exec:
	$(CONTAINER_RUNTIME) exec -it $(IMAGE_NAME) bash

.PHONY: clean
clean:
	$(CONTAINER_RUNTIME) rmi $(IMAGE_TAG)
