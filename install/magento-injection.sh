#!/usr/bin/env bash

if [ $1 ];
    then
        cd /var/www/html/$1/webroot
        composer install
    else
        echo "";
        echo "1st parameter is magento domain";
        echo "Try this: magento-injection.sh mywebshop.com";
        echo "";
fi;
