# Define project name
PROJECT_NAME=omniapi

# Mark targets as phony (not file-based)
.PHONY: up down restart logs artisan composer route install tinker migrate bash prune inspect

up:
	docker compose up -d --build

down:
	docker compose down

restart: down up

logs:
	docker compose logs -f $(PROJECT_NAME)

artisan:
	docker compose exec $(PROJECT_NAME) php artisan $(cmd)

composer:
	docker compose exec $(PROJECT_NAME) composer $(cmd)

install:
	docker compose exec $(PROJECT_NAME) composer install

tinker:
	docker compose exec -it $(PROJECT_NAME) php artisan tinker

migrate:
	docker compose exec -it $(PROJECT_NAME) php artisan migrate

bash:
	docker compose exec -it $(PROJECT_NAME) bash

prune:
	docker compose down -v --rmi all || true
	docker network rm omni-api-master_laravel-network || true
	docker system prune -af --volumes

inspect:
	docker inspect omniapi --format='{{.State.Health.Status}}'