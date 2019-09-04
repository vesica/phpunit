FROM php:7.3

# Setup Debian
RUN apt-get upgrade && apt-get update && ACCEPT_EULA=Y && apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        libzip-dev \
        libgeoip-dev \
        libxml2-dev \
        libxslt-dev \
        libtidy-dev \
        libssl-dev \
        zlib1g-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libaio1 \
        apt-file \
        wget \
        vim \
        gnupg \
        gnupg2 \
        zip \
        git

# Install PECLs
RUN pecl install redis \
    && pecl install geoip-1.1.1 \
    && pecl install apcu \
    && pecl install memcached \
    && pecl install timezonedb

RUN docker-php-ext-install -j$(nproc) calendar iconv bcmath xml gd mbstring pdo tidy gettext intl pdo pdo_mysql mysqli simplexml tokenizer xml xsl xmlwriter zip opcache exif \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-gd --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-enable redis geoip apcu memcached timezonedb

# Enable PHP error logging to stdout
RUN printf "log_errors = On \nerror_log = /dev/stderr\n" > /usr/local/etc/php/conf.d/php-logs.ini

# Composer
RUN mkdir -p /usr/local/ssh
COPY etc/ssh/* /usr/local/ssh/
RUN sh /usr/local/ssh/install-composer.sh
RUN mv composer.phar /usr/local/bin/composer

# Install phpunit
RUN wget -O phpunit https://phar.phpunit.de/phpunit-7.phar

RUN chmod +x phpunit && mv phpunit /usr/bin/phpunit

WORKDIR /app

################################
ENTRYPOINT ["phpunit"]
CMD ["--help"]
