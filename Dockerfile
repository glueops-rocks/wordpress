FROM ubuntu:20.04

# Update the package list and install necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
    apache2 \
    php7.4 \
    libapache2-mod-php7.4 \
    php7.4-mysql \
    php7.4-gd \
    curl \
    unzip \
    mysql-client

# Set the timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Download WordPress and the custom theme
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -zxvf latest.tar.gz && \
    mv wordpress /var/www/html && \
    rm latest.tar.gz && \
    curl -O https://downloads.wordpress.org/theme/twentynineteen.2.7.zip && \
    unzip twentynineteen.2.7.zip && \
    mv twentynineteen /var/www/html/wp-content/themes/

# Configure Apache and PHP
COPY wordpress.conf /etc/apache2/sites-enabled/
COPY fastcgi-php.conf /etc/apache2/snippets/
RUN chown -R www-data:www-data /var/www/html && \
    a2enmod rewrite && \
    a2enmod headers

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
