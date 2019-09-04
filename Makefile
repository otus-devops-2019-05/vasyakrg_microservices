DOCKER_REPO=vasyakrg
DOCKER_REPO_CRED=.docker-creds
APP_DIR=src
MONITORING_DIR=monitoring

EXT_TAG=logging

APPS = comment post ui alertmanager blackbox-exporter prometheus telefraf grafana trickster
APPS_MON = alertmanager blackbox-exporter prometheus telegraf grafana trickster

COMMENT_PATH = $(APP_DIR)/comment
POST_PATH = $(APP_DIR)/post-py
UI_PATH = $(APP_DIR)/ui

COMMENT_DEP = $(shell echo $(shell find $(COMMENT_PATH) -type f))
POST_DEP = $(shell echo $(shell find $(POST_PATH) -type f))
UI_DEP = $(shell echo $(shell find $(UI_PATH) -type f))

COMMENT_VERSION = $(shell head -n 1 $(COMMENT_PATH)/VERSION)
POST_VERSION = $(shell head -n 1 $(POST_PATH)/VERSION)
UI_VERSION = $(shell head -n 1 $(UI_PATH)/VERSION)

ALERTMANAGER_PATH = $(MONITORING_DIR)/alertmanager
ALERTMANAGER_DEP = $(shell echo $(shell find $(ALERTMANAGER_PATH) -type f))
BLACKBOX_EXPORTER_PATH = $(MONITORING_DIR)/blackbox-exporter
BLACKBOX_EXPORTER_DEP = $(shell echo $(shell find $(BLACKBOX_EXPORTER_PATH) -type f))
PROMETHEUS_PATH = $(MONITORING_DIR)/prometheus
PROMETHEUS_DEP = $(shell echo $(shell find $(PROMETHEUS_PATH) -type f))
TELEGRAF_PATH = $(MONITORING_DIR)/telegraf
TELEGRAF_DEP = $(shell echo $(shell find $(TELEGRAF_PATH) -type f))
GRAFANA_PATH = $(MONITORING_DIR)/grafana
GRAFANA_DEP = $(shell echo $(shell find $(GRAFANA_PATH) -type f))
TRICKSTER_PATH = $(MONITORING_DIR)/trickster
TRICKSTER_DEP = $(shell echo $(shell find $(TRICKSTER_PATH) -type f))

# HELP
# This will output the help for each task
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "- \033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.DEFAULT_GOAL := help

# DOCKER
# Build images
build: build-comment build-post build-ui build-alertmanager build-blackbox build-prometheus build-telegraf build-grafana build-trickster ## Build all docker images

build-apps: build-comment build-post build-ui ## Build apps-docker images

build-monitoring: build-alertmanager build-blackbox build-prometheus build-telegraf build-grafana build-trickster ## Build minitoring-docker images

build-comment: $(COMMENT_DEP) ## Build comment image
	docker build -t $(DOCKER_REPO)/comment $(COMMENT_PATH)

build-post: $(POST_DEP)## Build post image
	docker build -t $(DOCKER_REPO)/post $(POST_PATH)

build-ui: $(UI_DEP) ## Build ui image
	docker build -t $(DOCKER_REPO)/ui $(UI_PATH)

build-alertmanager: $(ALERTMANAGER_DEP) ## Build alertmanager image
	docker build -t $(DOCKER_REPO)/alertmanager $(ALERTMANAGER_PATH)

build-prometheus: $(PROMETHEUS_DEP) ## Build prometheus image
	docker build -t $(DOCKER_REPO)/prometheus $(PROMETHEUS_PATH)

build-blackbox: $(BLACKBOX_EXPORTER_DEP) ## Build blackbox-exporter image
	docker build -t $(DOCKER_REPO)/blackbox-exporter $(BLACKBOX_EXPORTER_PATH)

build-telegraf: $(TELEGRAF_DEP) ## Build telegraf image
	docker build -t $(DOCKER_REPO)/telegraf $(TELEGRAF_PATH)

build-grafana: $(GRAFANA_DEP) ## Build grafana image
	docker build -t $(DOCKER_REPO)/grafana $(GRAFANA_PATH)

build-trickster: $(TRICKSTER_DEP) ## Build trickster image
	docker build -t $(DOCKER_REPO)/trickster $(TRICKSTER_PATH)

release: build push ## Make a release by building and publishing the `{version}` ans `latest` tagged containers to Docker Hub

# Docker push
push: docker-login publish-latest publish-version ## Publish the `{version}` ans `latest` tagged containers to Docker Hub

publish-latest: docker-login ## Publish the `latest` taged container to Docker HubDocker Hub
	@echo 'publish latest to $(DOCKER_REPO)'
	for app in $(APPS); do \
		docker push $(DOCKER_REPO)/$${app}:latest; \
	done

publish-monitoring: docker-login ## Publish the 'latest' monitoring container to Docker HubDocker Hub
	@echo 'publish latest to $(DOCKER_REPO)'
	for app in $(APPS_MON); do \
		docker push $(DOCKER_REPO)/$${app}:latest; \
	done

publish-version: docker-login tag ## Publish the `{version}` taged container to Docker Hub
	@echo 'publish $(VERSION) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/comment:$(COMMENT_VERSION)
	docker push $(DOCKER_REPO)/post:$(POST_VERSION)
	docker push $(DOCKER_REPO)/ui:$(UI_VERSION)

publish-ext-version: docker-login ext-tag ## Publish the `{EXT_TAG}` taged container to Docker Hub
	@echo 'publish $(EXT_TAG) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/comment:$(EXT_TAG)
	docker push $(DOCKER_REPO)/post:$(EXT_TAG)
	docker push $(DOCKER_REPO)/ui:$(EXT_TAG)


tag: ## Generate container tag
	@echo 'create comment tag $(COMMENT_VERSION)'
	docker tag $(DOCKER_REPO)/comment $(DOCKER_REPO)/comment:$(COMMENT_VERSION)
	@echo 'create post tag $(POST_VERSION)'
	docker tag $(DOCKER_REPO)/post $(DOCKER_REPO)/post:$(POST_VERSION)
	@echo 'create ui tag $(UI_VERSION)'
	docker tag $(DOCKER_REPO)/ui $(DOCKER_REPO)/ui:$(UI_VERSION)

ext-tag: ## Generate container external-tag
	@echo 'create comment tag $(EXT_TAG)'
	docker tag $(DOCKER_REPO)/comment $(DOCKER_REPO)/comment:$(EXT_TAG)
	@echo 'create post tag $(EXT_TAG)'
	docker tag $(DOCKER_REPO)/post $(DOCKER_REPO)/post:$(EXT_TAG)
	@echo 'create ui tag $(EXT_TAG)'
	docker tag $(DOCKER_REPO)/ui $(DOCKER_REPO)/ui:$(EXT_TAG)


# Login to Docker Hub
docker-login: ## Login to Docker Hub
	test -s $(DOCKER_REPO_CRED) && cat $(DOCKER_REPO_CRED) | docker login --username $(DOCKER_REPO) --password-stdin || docker login --username $(DOCKER_REPO)
