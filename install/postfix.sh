#!/usr/bin/env bash

if [ $1 ];
    then
        sudo apt-get install postfix
        sudo apt-get install mailutils

        echo "root,www-data   info@$1" >> /etc/postfix/virtual

        curl https://github.com/ > /etc/postfix/main.cf
        sed -i -e "s/mywebshop.com/$1/g" /etc/postfix/main.cf

        sudo postmap /etc/postfix/virtual

        sudo service postfix reload
        sudo service postfix restart
    else
        echo "";
        echo "1st parameter is magento domain";
        echo "Try this: postfix.sh mywebshop.com";
        echo "";
fi;

