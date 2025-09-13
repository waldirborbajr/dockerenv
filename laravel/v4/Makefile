up:
	docker compose up --build -d

install:
	docker compose exec app composer install

down:
	docker compose down

bash:
	docker compose exec app bash

composer:
	docker compose exec app composer $(ARGS)

artisan:
	docker compose exec app php artisan $(ARGS)

logs:
	docker compose logs -f app
