FROM php:7.1-apache

RUN curl -o impresscms2.tar.gz -SL https://github.com/ImpressCMS/impresscms/archive/retro.tar.gz \
	&& tar -xzf impresscms2.tar.gz -C /var/www/html/ \
	&& rm impresscms2.tar.gz \
	&& chown -R www-data:www-data /var/www/html/impresscms-retro
	
RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip unzip libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmcrypt-dev \
        libmemcachedutil2 \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install gd 
	
	
RUN curl --silent --show-error https://getcomposer.org/installer | php

RUN cd /var/www/html/impresscms-retro \
	&& php -f /var/www/html/composer.phar install