FROM wordpress:6.1.1

RUN curl -L https://downloads.wordpress.org/theme/twentytwenty.1.7.zip -o twentytwenty.zip \
    && unzip twentytwenty.zip -d /usr/src/wordpress/wp-content/themes/ \
    && rm twentytwenty.zip \
    && echo 'define("WP_DEFAULT_THEME", "twentytwenty");' >> /usr/src/wordpress/wp-config.php
