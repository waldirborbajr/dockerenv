.PHONY: up down build start stop restart logs shell composer artisan install update clear migrate fresh init help

# Variáveis
DOCKER_COMPOSE = docker-compose
CONTAINER = laravel-dev

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

# Roda fresh migrations
fresh:
	@echo "Executando fresh migrations..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan migrate:fresh

# Inicialização completa do projeto
init:
	@echo "Inicialização completa do projeto..."
	$(DOCKER_COMPOSE) exec $(CONTAINER) sh -c "\
		composer install --ignore-platform-reqs && \
		if [ ! -f .env ]; then cp .env.example .env; fi && \
		php artisan key:generate --force && \
		php artisan optimize:clear"

# Roda o tinker
tinker:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan tinker

# Lista rotas
routes:
	$(DOCKER_COMPOSE) exec $(CONTAINER) php artisan route:list

# Help
help:
	@echo "Comandos disponíveis:"
	@echo "  make up          - Inicia o ambiente Docker"
	@echo "  make down        - Para o ambiente Docker"
	@echo "  make build       - Constrói a imagem Docker"
	@echo "  make init        - Inicialização completa (composer install + key generate)"
	@echo "  make logs        - Mostra os logs do container"
	@echo "  make shell       - Acessa o container via bash"
	@echo "  make composer    - Executa comando do Composer"
	@echo "  make artisan     - Executa comando do Artisan"
	@echo "  make install     - Instala dependências do Composer"
	@echo "  make update      - Atualiza dependências do Composer"
	@echo "  make clear       - Limpa o cache da aplicação"
	@echo "  make migrate     - Executa as migrations"
	@echo "  make fresh       - Executa migrate:fresh"
	@echo "  make tinker      - Abre o Tinker"

%:
	@:
