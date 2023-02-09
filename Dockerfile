FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    curl \
    apache2 \
    libapache2-mod-php \
    php \
    php-mysql

RUN curl -L https://wordpress.org/latest.tar.gz | tar xz -C /var/www/html --strip-components=1

COPY config/php.ini /etc/php/7.4/apache2/php.ini
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
