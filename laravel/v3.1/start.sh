#!/bin/bash

# Verifica se o .env existe, se não, copia o .env.example
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "Arquivo .env criado a partir de .env.example"
    else
        echo "AVISO: Arquivo .env.example não encontrado!"
    fi
fi

# Instala dependências do Composer
echo "Instalando dependências do Composer..."
composer install --no-interaction --prefer-dist --ignore-platform-reqs

# Gera key da aplicação se não existir
if [ -f .env ]; then
    if ! grep -q "APP_KEY=base64" .env; then
        echo "Gerando chave da aplicação..."
        php artisan key:generate --force
    fi
fi

# Configura permissões de storage
if [ -d storage ]; then
    chmod -R 775 storage/
    chown -R www-data:www-data storage/
fi

if [ -d bootstrap/cache ]; then
    chmod -R 775 bootstrap/cache/
    chown -R www-data:www-data bootstrap/cache/
fi

echo "Iniciando servidor Laravel..."
exec php artisan serve --host=0.0.0.0 --port=8000
