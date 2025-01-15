user := $(shell whoami)
git_branch := $(shell git rev-parse --abbrev-ref HEAD)
docker_tag := $(user)/wine:$(git_branch)

.PHONY: build
build: ## Build the Docker image
build:
	docker build --pull --platform linux/amd64,linux/arm64 -t $(docker_tag) .

.PHONY: push
push: ## Publish to Docker Hub
	docker push $(docker_tag)

.PHONY: help
help: ## Show this help text
	$(info usage: make [target])
	$(info )
	$(info Available targets:)
	@awk -F ':.*?## *' '/^[^\t].+?:.*?##/ \
         {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
