#!/usr/bin/env bash

apt-get install \
    nginx \
    --yes

service nginx restart
