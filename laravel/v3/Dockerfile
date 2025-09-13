FROM php:7.2-cli

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
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

# Configurações do PHP para desenvolvimento
RUN echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/memory.ini \
    && echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/time.ini

# Instala Composer versão específica compatível com PHP 7.2
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.17

# Define o diretório de trabalho
WORKDIR /var/www/html

# Permissões para desenvolvimento
RUN chmod -R 755 /var/www/html

# Expõe a porta para o artisan serve
EXPOSE 8000

# Health check para verificar se o servidor está rodando
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000 || exit 1
