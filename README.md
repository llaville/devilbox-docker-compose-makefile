# Devilbox docker-compose makefile

Makefile Template for docker-compose of the [Devilbox](https://github.com/cytopia/devilbox)

## INSTALLATION
To install mk-lib run command
```bash
curl -sL https://git.io/JJU2I | sh
```

## UPGRADE
To upgrade existing mk-lib run command
```bash
make mk-upgrade
```

## USAGE
**Common**
- `make console` - open PHP container's console

**From Makefile.minimal.mk** - samples
- `make up` - start all containers in foreground
- `make start` - start all containers in background
- `make start` **c=php** - start only php container
- `make stop` - stop all containers
- `make stop` **c=php** - stop only php container
- `make restart` - restart all containers
- `make restart` **c="httpd php"** - restart httpd and php containers
- `make status` - show list of containers with statuses
- `make down` - stop all containers and removes containers, networks, volumes, and images created by up or start
- `make compose` - configure the full stack containers
- `make compose` **c="elk"** - configure the stack with all default and elk containers
- `make compose` **DEVILBOX_COMPOSE_DIR=/path/to/compose_files c="revealjs portainer"** - configure the stack with all default and revealjs plus portainer containers

**From this library**
- `make help` - show help (see above)
- `make mk-upgrade` - check for updates of mk-lib
- `make mk-version` - show the current version of mk-lib

### VARIABLES
* **ROOT_DIR** - full path to dir with *Makefile*
* **MK_DIR** - fill path to *.mk-lib* dir
* **DOCKER_COMPOSE** - docker-compose executable command
* **DOCKER_COMPOSE_FILE** - docker-compose.yml file 
* **DOCKER_COMPOSE_OVERRIDE_FILE** - docker-compose.override.yml file

## SAMPLES
Basic commands (you can copy and paste it into your Makefile)

```makefile
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
```

## CUSTOMIZATION
You can create _.make.env_ file in the directory with Makefile or the current directory.

Available variables

* **DEVILBOX_CONTAINERS** = default containers to execute; Main containers {httpd php mysql pgsql redis memcd mongo} by default.

## CHANGELOG
See [CHANGELOG](CHANGELOG.md)

## LICENSE
MIT (see [LICENSE](LICENSE))

## AUTHOR
[Laurent Laville](https://github.com/llaville) Lead Dev of this project

## CREDITS
[Roman Kudlay](https://github.com/krom) for its [Makefile template for docker-compose](https://github.com/krom/docker-compose-makefile)
