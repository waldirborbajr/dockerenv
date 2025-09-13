PROJECT_NAME=laravel-app

up:
	docker-compose up -d --build

down:
	docker-compose down

restart: down up

logs:
	docker-compose logs -f $(PROJECT_NAME)

artisan:
	docker exec -it $(PROJECT_NAME) php artisan $(cmd)

composer:
	docker-compose run --rm composer $(cmd)

install:
	docker-compose run --rm composer install

tinker:
	docker exec -it $(PROJECT_NAME) php artisan tinker

migrate:
	docker exec -it $(PROJECT_NAME) php artisan migrate

bash:
	docker exec -it $(PROJECT_NAME) bash

