#!/usr/bin/env bash

apt-get install \
    apache2 \
    --yes

service apache2 restart
