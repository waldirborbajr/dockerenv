#!/bin/sh

# Configurações baseadas em variáveis de ambiente
echo "Iniciando aplicação Laravel em modo: ${APP_ENV:-production}"

# Verifica se é necessário recriar caches (apenas se .env mudou)
if [ "$APP_ENV" = "production" ]; then
    echo "Verificando caches de configuração..."
    
    # Recria caches apenas se .env foi modificado
    if [ ! -f bootstrap/cache/config.php ] || [ .env -nt bootstrap/cache/config.php ]; then
        echo "Recriando cache de configuração..."
        php artisan config:cache
    fi
    
    if [ ! -f bootstrap/cache/routes.php ] || [ .env -nt bootstrap/cache/routes.php ]; then
        echo "Recriando cache de rotas..."
        php artisan route:cache
    fi
    
    if [ ! -f bootstrap/cache/packages.php ] || [ .env -nt bootstrap/cache/packages.php ]; then
        echo "Recriando cache de packages..."
        php artisan package:discover
    fi
fi

# Garante permissões corretas
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# Inicia Apache em primeiro plano
echo "Iniciando Apache..."
exec apache2-foreground
