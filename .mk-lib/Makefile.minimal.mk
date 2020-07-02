# REQUIRED SECTION
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ROOT_DIR)/.mk-lib/common.mk
# END OF REQUIRED SECTION

.PHONY: help up down start stop restart status console compose

up: ## Start all or c=<name> containers in foreground
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) up $(c)

down: ## Stop all containers and removes containers, networks, volumes, and images created by up or start
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) down --remove-orphans

start: ## Start all or c=<name> containers in background
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) up -d $(c)

stop: ## Stop all or c=<name> containers
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) stop $(c)

restart: ## Restart all or c=<name> containers
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) stop $(c)
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) up -d $(c)

status: ## Show status of containers
	@$(DOCKER_COMPOSE) $(strip -f $(DOCKER_COMPOSE_FILE) -f $(DOCKER_COMPOSE_OVERRIDE_FILE) $(foreach container,$(filter-out $(DEVILBOX_MAIN_CONTAINERS),$(DEVILBOX_CONTAINERS)),-f $(DEVILBOX_COMPOSE_DIR)/$(DEVILBOX_COMPOSE_FILE_PATTERN)$(container))) ps

console: ## Enter the php container
	@$(DOCKER_COMPOSE) exec --user devilbox php bash -l

compose: ## Configure the stack containers with c=<name> list
	@$(file > $(MAKE_ENV),DEVILBOX_CONTAINERS=$(strip $(c)))
	@echo Devilbox Stack is composed. $(MAKE_ENV) file was updated.
