FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y apache2 curl wget nano php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-gd php7.2-intl php7.2-mbstring php7.2-soap php7.2-xml php7.2-zip

# Set the timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xzf latest.tar.gz
RUN rm latest.tar.gz
RUN mv wordpress /var/www/html/

# Configure Apache
COPY wordpress.conf /etc/apache2/sites-enabled/
COPY fastcgi-php.conf /etc/apache2/snippets/
RUN a2enmod rewrite
RUN a2dissite 000-default.conf

# Copy custom theme to the WordPress installation
COPY themes/twentyseventeen /var/www/html/wp-content/themes/

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
