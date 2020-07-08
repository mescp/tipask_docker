FROM php:7-apache

RUN sed -i "s@deb.debian.org@mirrors.aliyun.com@g" /etc/apt/sources.list && \
    apt-get update \
        && apt-get install -y \
          git \
          gcc g++ \
          libfreetype6-dev \
          libjpeg62-turbo-dev \
          libmcrypt-dev \
          libpng-dev \
          zip \
        && pecl install mcrypt \
        && a2enmod rewrite \
        && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) iconv \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd \ 
  && docker-php-ext-install pdo pdo_mysql \
  && docker-php-ext-enable mcrypt

ADD getcomposer.php /tmp/getcomposer.php 
RUN cat /tmp/getcomposer.php | php -- --install-dir=/usr/local/bin --filename=composer;

ADD apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD php.ini /usr/local/etc/php/

COPY src /var/www/html/tipask

WORKDIR /var/www/html/tipask

RUN composer install; 
RUN touch .env && chmod 777 -R .env storage bootstrap/cache
