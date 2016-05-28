#!/usr/bin/env bash

if [ $1 ];
    then
        debconf-set-selections <<< "postfix postfix/mailname string $1"
        debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

        apt-get install \
            postfix \
            mailutils \
            --yes

        echo "root,www-data   info@$1" >> /etc/postfix/virtual

        curl https://raw.githubusercontent.com/DoveID/magento2-server-configuration/master/config/postfix-config > /etc/postfix/main.cf
        sed -i -e "s/mywebshop.com/$1/g" /etc/postfix/main.cf

        postmap /etc/postfix/virtual

        service postfix reload
        service postfix restart
    else
        echo "";
        echo "1st parameter is magento domain";
        echo "Try this: postfix.sh mywebshop.com";
        echo "";
fi;

