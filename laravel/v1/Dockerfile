FROM php:7.4-cli

# Dependências Laravel + Firebird
RUN apt-get update && apt-get install -y \
    firebird-dev \
    libicu-dev \
    libzip-dev \
    unzip \
    git \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalador oficial de extensões PHP
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions \
        pdo_firebird \
        pdo_mysql \
        intl \
        mbstring \
        bcmath \
        zip \
        gd \
        gmp \
        curl \
        dom \
        json

WORKDIR /var/www/html

