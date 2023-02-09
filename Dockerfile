FROM php:7.4-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip

# Download and extract the latest Wordpress
RUN curl -L https://wordpress.org/latest.tar.gz | tar xz -C /var/www/html --strip-components=1

# Download and extract the twentytwenty theme
RUN curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip \
    && unzip twentytwenty.zip -d /var/www/html/wp-content/themes/ \
    && rm twentytwenty.zip

# Set the twentytwenty theme as the default theme
RUN echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> /var/www/html/wp-config.php

# Set the Apache document root
ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
