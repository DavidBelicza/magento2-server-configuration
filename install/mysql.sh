#!/usr/bin/env bash

if [ $1 ] && [ $2 ];
    then
        debconf-set-selections <<< "mysql-server mysql-server/root_password password $2"
        debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $2"

        apt-get install mysql-server --yes

        service mysql start

        mysql -u root --password="$2" << EOF
            DELETE FROM mysql.user WHERE User='';
            DROP DATABASE IF EXISTS test;
            CREATE DATABASE IF NOT EXISTS $1;
            FLUSH PRIVILEGES;
            SHOW DATABASES;
EOF

    else
        echo "Missing parameters.";
        echo "1st parameter is MySQL Magento database";
        echo "2nd parameter is MySQL root password";
        echo "Try this: mysql.sh magento2 secret123";
        echo "FAILED";
fi;
