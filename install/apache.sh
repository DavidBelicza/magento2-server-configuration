#!/usr/bin/env bash

apt-get install \
    apache2 \
    libapache2-mod-fastcgi \
    --yes

a2dismod \
    mpm_event

a2enmod \
    mpm_worker \
    rewrite \
    fastcgi \
    proxy \
    proxy_fcgi \
    alias \
    actions

service apache2 restart
