#!/usr/bin/env bash

if [ $1 ] && [ $2 ] && [ $3 ] && [ $4 ];
    then
        sudo adduser $3 --gecos "Magento System,0,0,0" --disabled-password
        echo "$3:$4" | sudo chpasswd
        usermod -g www-data magento

        mkdir /var/www/html/$2
        mkdir /var/www/html/$2/webroot
        mkdir /var/www/html/$2/log

        echo "Download Magento $1 release"

        mkdir ~/temp
        cd ~/temp
        wget https://github.com/magento/magento2/archive/$1.zip
        DOWNLOADED_ZIP=$(ls -t *.zip | head -1)
        unzip -o $DOWNLOADED_ZIP -d /var/www/html
        cd /var/www/html
        RELEASE_FOLDER="magento2-"$1
        rm -rf /var/www/html/$2/webroot/*
        mv /var/www/html/$RELEASE_FOLDER/* /var/www/html/$2/webroot/
        rm -rf /var/www/html/$RELEASE_FOLDER

        cd /var/www/html/$2/webroot
        chown -R :www-data .
        find . -type d -exec chmod 770 {} \;
        find . -type f -exec chmod 660 {} \;
        chmod u+x bin/magento

        SITE=/etc/nginx/sites-available/$2
        curl https://raw.githubusercontent.com/DoveID/magento2-server-configuration/master/config/nginx-site > $SITE

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
