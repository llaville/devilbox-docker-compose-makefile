MK_DIR := $(ROOT_DIR)/.mk-lib
include $(MK_DIR)/variables.mk
-include $(MK_DIR)/version.mk
-include $(ROOT_DIR)/.make.env
-include .make.env

MK_VERSION ?= 1.x-dev

f ?= $(DOCKER_COMPOSE_FILE)
DOCKER_COMPOSE_FILE := $(f)

DEVILBOX_MAIN_CONTAINERS ?= httpd php mysql pgsql redis memcd mongo

DEVILBOX_COMPOSE_FILE_PATTERN ?= docker-compose.override.yml-
DEVILBOX_COMPOSE_DIR ?= $(ROOT_DIR)/compose
COMPOSE_DIR := $(DEVILBOX_COMPOSE_DIR)

ifneq ("$(wildcard .make.env)","")
    MAKE_ENV := .make.env
else
    MAKE_ENV := $(ROOT_DIR)/.make.env
endif

.DEFAULT_GOAL := help

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

mk-upgrade: ##@other Check for updates of mk-lib
	@MK_VERSION=$(MK_VERSION) MK_REPO=$(MK_REPO) $(MK_DIR)/self-upgrade.sh

mk-version: ##@other Show current version of mk-lib
	@echo $(MK_VERSION)
