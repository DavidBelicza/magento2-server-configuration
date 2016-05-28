#!/usr/bin/env bash

if [ $1 ] && [ $2 ];
    then
        cd /var/www/html/$1/webroot

        php bin/magento sampledata:deploy
        composer update
        php bin/magento setup:upgrade

        php bin/magento setup:static-content:deploy $2

        php bin/magento cache:clean
        php bin/magento cache:flush

    else
        echo "";
        echo "1st parameter is magento domain";
        echo "2nd parameter is language code";
        echo "Try this: magento-sample.sh mywebshop.com";
        echo "";
fi;

