#!/usr/bin/env bash

apt-get install \
    apache2-mpm-worker \
    --yes

service apache2 restart
