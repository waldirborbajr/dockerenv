# ./Dockerfile
FROM php:7.4-cli

# Set timezone
ENV TZ=America/Sao_Paulo

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libicu-dev \
    firebird-dev \
    libzip-dev \
    libpng-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala extensões PHP necessárias
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        pdo_firebird \
        intl \
        zip \
        gd \
        bcmath \
        pcntl \
        exif

# Instala Composer 2.x
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Define pasta do projeto (montada via volume no docker-compose)
WORKDIR /var/www/html

# Comando padrão para subir o servidor Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=9005"]
