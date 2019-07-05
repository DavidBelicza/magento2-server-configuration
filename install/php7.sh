#!/usr/bin/env bash

apt-get install \
    php-fpm \
    php-mysql \
    php-mcrypt \
    php-curl \
    php-cli \
    php-gd \
    php7.2-xsl \
    php-json \
    php-intl \
    php-pear \
    php-dev \
    php-common \
    php-soap \
    php-mbstring \
    php-zip \
    php7.2-bcmath \
    php-imagick \
    --yes

service php7.2-fpm restart
