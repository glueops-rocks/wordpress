FROM wordpress:5.7.1-php7.4-apache

# Copy custom theme
COPY themes/twentyseventeen /var/www/html/wp-content/themes/twentyseventeen

# Set the timezone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the Apache configuration file
COPY wordpress.conf /etc/apache2/sites-enabled/

# Copy the FastCGI configuration file
COPY fastcgi-php.conf /etc/apache2/snippets/
