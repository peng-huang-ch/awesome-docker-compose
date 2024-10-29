# Detect if running on Apple Silicon (M1)
UNAME_MACHINE := $(shell uname -m)
IS_ARM := $(shell [ "$(UNAME_MACHINE)" = "arm64" ] && echo 1 || echo 0)

# Default Docker platform based on architecture
DOCKER_DEFAULT_PLATFORM := $(if $(filter 1,$(IS_ARM)),linux/amd64,)

# Define default profile and tags
KONG_DOCKER_TAG := kong/kong:3.8
KONG_DATABASE := postgres

# Targets
.PHONY: prepare kong-postgres kong-dbless kong-gateway clean datadir

prepare:
ifeq ($(IS_ARM),1)
	@echo "Running on Apple Silicon (arm64), setting DOCKER_DEFAULT_PLATFORM to $(DOCKER_DEFAULT_PLATFORM)"
	export DOCKER_DEFAULT_PLATFORM=$(DOCKER_DEFAULT_PLATFORM)
endif

kong-postgres: prepare
	KONG_DOCKER_TAG=kong/kong:3.8 COMPOSE_PROFILES=database KONG_DATABASE=postgres docker compose up -d

kong-dbless: prepare
	docker-compose -f docker-compose.yaml up -d

kong-gateway: prepare
	KONG_DOCKER_TAG=kong/kong-gateway:3.8 COMPOSE_PROFILES=database KONG_DATABASE=postgres docker compose -f docker-compose.yaml up -d

clean: prepare
	docker-compose down --remove-orphans

datadir:
	mkdir -p data/{kong,prefix,tmp}