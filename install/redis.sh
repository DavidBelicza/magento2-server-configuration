#!/usr/bin/env bash

apt-get install \
    build-essential \
    tcl \
    --yes

curl -O http://download.redis.io/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
make
#make test
make install
