# Stage 1: Builder - Instala dependências e compila assets (usando Debian para compatibilidade)
FROM php:7.2-cli as builder

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instala extensões do PHP necessárias
RUN docker-php-ext-install \
    intl \
    pdo \
    mysqli \
    mbstring \
    xml \
    zip \
    opcache

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.17

# Copia os fontes para o container
WORKDIR /var/www/html
COPY src/ .

# Instala dependências (sem dev dependencies) e otimiza autoloader
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress

# Otimiza a aplicação Laravel
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

# Remove arquivos desnecessários para produção
RUN rm -rf \
    tests/ \
    *.md \
    .editorconfig \
    .gitattributes \
    .gitignore \
    .styleci.yml \
    package.json \
    webpack.mix.js \
    node_modules/ \
    storage/framework/cache/data/* \
    storage/framework/views/* \
    storage/logs/*

# Stage 2: Production - Imagem final Alpine otimizada
FROM webdevops/php-apache:7.2-alpine

# Instala dependências runtime necessárias
RUN apk update && apk add --no-cache \
    icu-libs \
    libxml2 \
    libzip \
    # Dependências para extensões PHP
    libintl \
    libxslt \
    && rm -rf /var/cache/apk/*

# Instala extensões PHP necessárias
RUN docker-php-ext-install \
    intl \
    pdo \
    mysqli \
    mbstring \
    xml \
    zip \
    opcache

# Configurações do PHP para produção
RUN echo "memory_limit = 256M" > /usr/local/etc/php/conf.d/production.ini \
    && echo "upload_max_filesize = 50M" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "post_max_size = 50M" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "max_execution_time = 120" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "max_input_time = 120" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "display_startup_errors = Off" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "error_log = /var/log/php/error.log" >> /usr/local/etc/php/conf.d/production.ini \
    && echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.max_accelerated_files=10000" >> /usr/local/etc/php/conf.d/opcache.ini \
    && echo "opcache.validate_timestamps=0" >> /usr/local/etc/php/conf.d/opcache.ini

# Cria diretório para logs do PHP
RUN mkdir -p /var/log/php && chown www-data:www-data /var/log/php

# Configura usuário e grupo padrão
RUN chown -R www-data:www-data /var/www/html

# Copia configurações do Apache
COPY apache2.conf /etc/apache2/apache2.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

# Copia aplicação do stage builder
COPY --from=builder --chown=www-data:www-data /var/www/html/ /var/www/html/

# Cria diretórios de storage e configura permissões
RUN mkdir -p storage/framework/{sessions,views,cache} storage/logs bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Script de inicialização
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Expõe portas
EXPOSE 80

# Define usuário não-root
USER www-data

# Comando de inicialização
CMD ["/usr/local/bin/start.sh"]
