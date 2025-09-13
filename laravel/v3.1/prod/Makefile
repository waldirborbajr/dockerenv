.PHONY: build build-dev up down restart logs shell deploy clean help

# Variáveis
DOCKER_COMPOSE = docker-compose
CONTAINER = laravel-prod
APP_KEY ?= base64:your-generated-key-here

# Construir imagem de produção (multi-stage)
build:
	@echo "Construindo imagem de produção com multi-stage build..."
	$(DOCKER_COMPOSE) build --no-cache

# Construir stage específico para desenvolvimento
build-dev:
	@echo "Construindo stage de desenvolvimento..."
	docker build --target builder -t laravel-builder .

# Iniciar serviços
up:
	@echo "Iniciando ambiente de produção..."
	APP_KEY=$(APP_KEY) $(DOCKER_COMPOSE) up -d

# Parar serviços
down:
	@echo "Parando ambiente de produção..."
	$(DOCKER_COMPOSE) down

# Reiniciar serviços
restart:
	@echo "Reiniciando ambiente..."
	$(DOCKER_COMPOSE) restart

# Ver logs
logs:
	$(DOCKER_COMPOSE) logs -f

# Acessar container
shell:
	$(DOCKER_COMPOSE) exec $(CONTAINER) bash

# Deploy completo
deploy:
	@echo "Executando deploy completo..."
	$(MAKE) down
	$(MAKE) build
	APP_KEY=$(APP_KEY) $(DOCKER_COMPOSE) up -d
	@echo "Deploy concluído! Verificando saúde da aplicação..."
	sleep 10
	$(DOCKER_COMPOSE) ps

# Limpar ambiente
clean:
	@echo "Limpando ambiente..."
	$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans
	rm -rf logs/*

# Gerar APP_KEY
generate-key:
	@echo "Gerando APP_KEY..."
	@docker run --rm -it \
		-v $(PWD)/src:/var/www/html \
		-w /var/www/html \
		php:7.2-cli \
		php artisan key:generate --show

# Verificar tamanho da imagem
size:
	@echo "Tamanho das imagens:"
	@docker images laravel-prod --format "{{.Repository}}: {{.Size}}"

# Otimizar composer autoload
optimize:
	@echo "Otimizando autoload..."
	@docker run --rm -it \
		-v $(PWD)/src:/var/www/html \
		-w /var/www/html \
		composer:1.10.17 \
		composer dump-autoload --optimize

# Help
help:
	@echo "Comandos disponíveis para produção:"
	@echo "  make build        - Construir imagem com multi-stage"
	@echo "  make build-dev    - Construir apenas stage de builder"
	@echo "  make up           - Iniciar serviços"
	@echo "  make down         - Parar serviços"
	@echo "  make deploy       - Deploy completo"
	@echo "  make restart      - Reiniciar serviços"
	@echo "  make logs         - Ver logs"
	@echo "  make shell        - Acessar container"
	@echo "  make generate-key - Gerar nova APP_KEY"
	@echo "  make clean        - Limpar ambiente completamente"
	@echo "  make size         - Ver tamanho da imagem"
	@echo "  make optimize     - Otimizar autoload do Composer"

%:
	@:
