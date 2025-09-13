FROM php:7.4-cli

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update && apt-get install -y \
    git unzip libicu-dev firebird-dev libpng-dev libzip-dev libonig-dev default-mysql-client default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions pdo_firebird pdo_mysql intl zip gd mbstring exif pcntl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN groupadd -g ${GROUP_ID} www && useradd -u ${USER_ID} -g www -m www

WORKDIR /var/www/html
USER www

EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
