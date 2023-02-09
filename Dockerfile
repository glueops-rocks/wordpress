FROM wordpress:latest

RUN apt-get update && apt-get install -y nano

RUN echo "body { background-color: green; }" >> /var/www/html/wp-content/themes/twentytwenty/style.css
