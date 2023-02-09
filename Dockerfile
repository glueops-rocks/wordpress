# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set the timezone
ENV TZ=America/Los_Angeles

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    curl \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy fastcgi-php.conf file
COPY fastcgi-php.conf /etc/apache2/snippets/

# Enable the Apache rewrite module
RUN a2enmod rewrite

# Add the Apache virtual host configuration for WordPress
COPY wordpress.conf /etc/apache2/sites-enabled/

# Start the Apache service
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
