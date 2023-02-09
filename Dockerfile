FROM wordpress:latest

RUN apt-get update && apt-get install -y unzip nano && \
    mkdir -p /var/www/html/wp-content/themes/twentytwenty && \
    curl -L https://downloads.wordpress.org/theme/twentytwenty.1.8.zip -o twentytwenty.zip && \
    unzip twentytwenty.zip -d /var/www/html/wp-content/themes/ && \
    rm twentytwenty.zip

RUN echo "body { background-color: green; }" >> /var/www/html/wp-content/themes/twentytwenty/style.css
