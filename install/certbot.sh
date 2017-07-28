#!/usr/bin/env bash

apt-get install \
    software-properties-common \
    --yes

add-apt-repository ppa:certbot/certbot
apt-get update

apt-get install \
    certbot \
    --yes
