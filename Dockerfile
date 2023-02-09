FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl unzip apache2 php libapache2-mod-php php-mysql

WORKDIR /var/www/html

RUN curl -L https://wordpress.org/latest.tar.gz | tar xz --strip-components=1

RUN curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip && \
    unzip twentytwenty.zip -d wp-content/themes/ && \
    rm twentytwenty.zip && \
    echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> wp-config.php

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
