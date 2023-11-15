FROM php:8.1-apache

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /home/demo

RUN apt-get update \
    && apt-get install -y libzip-dev zip unzip \
    && docker-php-ext-install pdo_mysql zip \
    && a2enmod rewrite \
    && service apache2 restart

COPY . /home/demo

RUN chown -R www-data:www-data /home/demo/storage /home/demo/bootstrap/cache

EXPOSE 80

CMD ["apache2-foreground"]