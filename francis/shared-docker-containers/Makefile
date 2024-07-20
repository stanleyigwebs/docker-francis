help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: up

up:  ## Bring containers up.
	@docker compose up --force-recreate --build -d

.PHONY: down

down:  ## Bring containers down.
	@docker compose down

.PHONY: build

build: ## Build all containers 
	@docker compose build

.PHONY: build-no-cache

build-no-cache: ## Build all containers without cache
	@docker compose build --no-cache

.PHONY: restart

restart: ## Restart containers
	make down
	make up 

.PHONY: execute

execute: ## Bash into a specific container (Usage: make execute CONTAINER=<container_name>)
	docker exec -it $${CONTAINER} bash