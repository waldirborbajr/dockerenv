.PHONY: up down build start stop restart logs shell composer artisan install update clear migrate help

# Variáveis
DOCKER_COMPOSE = docker-compose
CONTAINER = laravel-dev
PROJECT_DIR = ${HOME}/prj/megaapi

# Inicia o ambiente
up:
	@echo "Iniciando ambiente Laravel..."
	$(DOCKER_COMPOSE) up -d

# Para o ambiente
down:
	@echo "Parando ambiente..."
	$(DOCKER_COMPOSE) down

# Constrói a imagem
build:
	@echo "Construindo imagem Docker..."
	$(DOCKER_COMPOSE) build

# Inicia os containers
start:
	$(DOCKER_COMPOSE) start

# Para os containers
stop:
	$(DOCKER_COMPOSE) stop

# Reinicia os containers
restart:
	$(DOCKER_COMPOSE) restart

# Mostra os logs
logs:
	$(DOCKER_COMPOSE) logs -f

# Acessa o container
shell:
	$(DOCKER_COMPOSE) exec $(CONTAINER) bash

# Executa comandos do Composer
composer:
	$(DOCKER_COMPOSE) exec $(CONTAINER) composer $(filter-out $@,$(MAKECMDGOALS))

# Executa comandos do Artisan
artisan:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan $(filter-out $@,$(MAKECMDGOALS))

# Instala as dependências
install:
	@echo "Instalando dependências do Composer..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) composer install --ignore-platform-reqs

# Atualiza as dependências
update:
	@echo "Atualizando dependências..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) composer update --ignore-platform-reqs

# Limpa o cache
clear:
	@echo "Limpando cache..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan optimize:clear

# Roda as migrations
migrate:
	@echo "Executando migrations..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan migrate

# Roda o tinker
tinker:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan tinker

# Lista rotas
routes:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan route:list

# Inicia o servidor manualmente (se necessário)
serve:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan serve --host=0.0.0.0 --port=8000

# Help
help:
	@echo "Comandos disponíveis:"
	@echo "  make up          - Inicia o ambiente Docker"
	@echo "  make down        - Para o ambiente Docker"
	@echo "  make build       - Constrói a imagem Docker"
	@echo "  make logs        - Mostra os logs do container"
	@echo "  make shell       - Acessa o container via bash"
	@echo "  make composer    - Executa comando do Composer (ex: make composer require package)"
	@echo "  make artisan     - Executa comando do Artisan (ex: make artisan make:model Test)"
	@echo "  make install     - Instala dependências do Composer"
	@echo "  make update      - Atualiza dependências do Composer"
	@echo "  make clear       - Limpa o cache da aplicação"
	@echo "  make migrate     - Executa as migrations"
	@echo "  make tinker      - Abre o Tinker"
	@echo "  make routes      - Lista as rotas da aplicação"

%:
	@:
