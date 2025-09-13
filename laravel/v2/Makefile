# Makefile
APP_CONTAINER=laravel_app

up:
	docker-compose up -d --build

down:
	docker-compose down

logs:
	docker-compose logs -f $(APP_CONTAINER)

bash:
	docker exec -it $(APP_CONTAINER) bash

composer-install:
	docker exec -it $(APP_CONTAINER) composer install

artisan:
	docker exec -it $(APP_CONTAINER) php artisan $(CMD)

migrate:
	docker exec -it $(APP_CONTAINER) php artisan migrate

init: up composer-install
	docker exec -it $(APP_CONTAINER) php artisan key:generate
