.PHONY: help up recreate down build build-no-cache restart execute

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

up:  ## Bring containers up.
	@docker compose up -d

recreate:  ## Recreate containers.
	@make down
	@docker compose up --force-recreate --build -d

down:  ## Bring containers down.
	@docker compose down

build: ## Build all containers.
	@docker compose build

build-no-cache: ## Build all containers without cache.
	@docker compose build --no-cache

restart: ## Restart containers.
	@make down
	@make up

execute: ## Bash into a specific container (Usage: make execute service=<service_name>).
	@docker compose exec -it $${SERVICE} bash
