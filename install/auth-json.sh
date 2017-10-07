#!/usr/bin/env bash

if [ $1 ] && [ $2 ] && [ $3 ];
    then
        rm /var/www/html/$1/composer/auth.json
        mkdir /var/www/html/$1/composer
        echo "{\"http-basic\":{\"repo.magento.com\":{\"username\":\""$2"\", \"password\":\""$3"\"}}}" >> /var/www/html/$1/composer/auth.json
    else
        echo ""
        echo "1st parameter is magento domain";
        echo "2nd parameter is magento connect public key";
        echo "3rd parameter is magento connect private key";
        echo "Try this: auth-json.sh magento.com 123456789 123456789"
        echo ""
fi;
