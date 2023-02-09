# Use the official Ubuntu image as the base image
FROM ubuntu:20.04

# Set the timezone to Pacific Standard Time
ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Add configuration files
COPY wordpress.conf /etc/apache2/sites-available/
COPY fastcgi-php.conf /etc/apache2/snippets/fastcgi-php.conf

# Install required packages
RUN apt-get update && apt-get install -y curl apache2 php7.4 php7.4-mysql libapache2-mod-php7.4 wget unzip

# Download and install WordPress
RUN wget https://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz -C /var/www/html --strip-components=1

# Download and install the Twenty Twenty theme
RUN curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip && \
    unzip twentytwenty.zip -d /var/www/html/wp-content/themes/ && \
    rm twentytwenty.zip && \
    echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> /var/www/html/wp-config.php

# Set up Apache
RUN a2enmod rewrite
RUN a2dissite 000-default.conf && a2ensite wordpress.conf

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
