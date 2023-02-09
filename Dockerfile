FROM php:7.4-apache

RUN apt-get update && apt-get install -y curl \
    && curl -L https://wordpress.org/latest.tar.gz | tar xz -C /var/www/html --strip-components=1 \
    && curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip \
    && unzip twentytwenty.zip -d /var/www/html/wp-content/themes/ \
    && rm twentytwenty.zip \
    && echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> /var/www/html/wp-config.php
