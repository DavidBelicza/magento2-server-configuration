#!/usr/bin/env bash

if [ $1 ] && [ $2 ] && [ $3 ] && [ $4 ];
    then
        sudo adduser $3 --gecos "Magento System,0,0,0" --disabled-password
        echo "$3:$4" | sudo chpasswd
        usermod -g www-data $3

        mkdir /var/www/html/$2
        mkdir /var/www/html/$2/webroot
        mkdir /var/www/html/$2/log

        echo "Download Magento $1 release"

        cd /var/www/html
        rm -rf /var/www/html/$2/webroot/*

        cd /var/www/html/$2/webroot
        chown -R :www-data .
        find . -type d -exec chmod 770 {} \;
        find . -type f -exec chmod 660 {} \;
        chmod u+x bin/magento

        SITE=/etc/nginx/sites-available/$2
        curl https://raw.githubusercontent.com/DavidBelicza/magento2-server-configuration/master/config/nginx-site > $SITE

        sed -i -e "s/mywebshop.com/$2/g" $SITE
        ln -s /etc/nginx/sites-available/$2 /etc/nginx/sites-enabled/

        service nginx reload
    else
        echo ""
        echo "Missing parameters.";
        echo "1st parameter is magento release";
        echo "2nd parameter is magento folder name what is same as the domain address";
        echo "3rd parameter is magento linux user (it will create it)";
        echo "4th parameter is magento linux password (it will create it)";
        echo "Try this: magento-prepare.sh 2.0.7 mywebshop.com magento magento";
        echo "";
fi;
