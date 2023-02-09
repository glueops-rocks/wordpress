FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    unzip \
    php \
    libapache2-mod-php

RUN curl -L https://wordpress.org/latest.tar.gz | tar xz -C /var/www/html --strip-components=1

COPY fastcgi-php.conf /etc/apache2/snippets/fastcgi-php.conf

RUN curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip && \
    unzip twentytwenty.zip -d /var/www/html/wp-content/themes/ && \
    rm twentytwenty.zip && \
    echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> /var/www/html/wp-config.php

COPY wordpress.conf /etc/apache2/sites-enabled/wordpress.conf

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
