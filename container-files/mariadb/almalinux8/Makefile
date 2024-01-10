# make params
MAKEFLAGS = -j 4

# container image args
IMAGE_NAME = mariadb
TAG = almalinux8-$(MARIADB_VERSION)-$(BUILD_DATE)

# args
MARIADB_VERSION = 10.11

# container params
CONTAINER_RUNTIME = podman
REPO_URL = $(shell git remote get-url origin)
REPO_OWNER = $(shell basename $$(dirname $(REPO_URL)))
REPO_NAME = $(shell basename $(REPO_URL) .git)
NAMESPACE = $(REPO_OWNER)/$(REPO_NAME)
REGISTRY = ghcr.io
IMAGE_TAG = $(REGISTRY)/$(NAMESPACE)/$(IMAGE_NAME):$(TAG)

# container build params
COMMON_BUILD_ARGS = --build-arg MARIADB_VERSION=$(MARIADB_VERSION)
BUILD_ARGS = --rm
REBUILD_ARGS = --no-cache --squash --rm
BUILD_DATE = 20240110

# container run args
RUN_ARGS = --rm -it
RUN_CMD = bash
START_ARGS = -p 3306:3306

.PHONY: build
build: Containerfile docker-entrypoint.sh
	$(CONTAINER_RUNTIME) build $(COMMON_BUILD_ARGS) $(BUILD_ARGS) -t $(IMAGE_TAG) -f Containerfile .

.PHONY: rebuild
rebuild: Containerfile docker-entrypoint.sh
	$(CONTAINER_RUNTIME) build $(COMMON_BUILD_ARGS) $(REBUILD_ARGS) -t $(IMAGE_TAG) -f Containerfile .

.PHONY: run
run: $(BUILD_FILES)
	$(CONTAINER_RUNTIME) run $(RUN_ARGS) $(IMAGE_TAG) $(RUN_CMD)

.PHONY: start
start: $(BUILD_FILES)
	$(CONTAINER_RUNTIME) run $(START_ARGS) -d --name $(IMAGE_NAME) $(IMAGE_TAG)

.PHONY: stop
stop: $(BUILD_FILES)
	$(CONTAINER_RUNTIME) rm -f $(IMAGE_NAME)

.PHONY: restart
restart: stop start

.PHONY: exec
exec:
	$(CONTAINER_RUNTIME) exec -it $(IMAGE_NAME) bash

.PHONY: clean
clean: $(BUILD_FILES)
	$(CONTAINER_RUNTIME) rmi $(IMAGE_TAG)
