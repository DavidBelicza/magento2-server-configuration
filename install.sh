#!/usr/bin/env bash

# This script installs the Magento and its server environment. It installs
# Nginx, PHP7, MySQL, Postfix, Composer, Magento 2, Magento sample data and all
# required packages and dependencies. It also set the Linux swapping and Vhost
# configuration.
#
# This script makes ready Magento 2 to work for development and sets a single
# one store for one website.
#
# This Magento environment fine for module and template development and Magento
# core contribution development.
#
# Pre-requirements: Ubuntu 16 with Internet connection.
#
# To install Magento, first fill out the install.ini file then run the command
# "sudo bash install.sh"
#
# YOUAMA 2016
# CREATED BY DAVID BELICZA

DOMAIN=$(awk -F "=" '/domain/ {print $2}' install.ini)
BASE_URL=$(awk -F "=" '/base_url/ {print $2}' install.ini)
MAGENTO_RELEASE=$(awk -F "=" '/magento_release/ {print $2}' install.ini)
DATABASE_HOST=$(awk -F "=" '/database_host/ {print $2}' install.ini)
DATABASE_NAME=$(awk -F "=" '/database_name/ {print $2}' install.ini)
DATABASE_USER=$(awk -F "=" '/database_user/ {print $2}' install.ini)
DATABASE_PASS=$(awk -F "=" '/database_pass/ {print $2}' install.ini)
LINUX_MAGENTO_USER_NAME=$(awk -F "=" '/linux_magento_user_name/ {print $2}' install.ini)
LINUX_MAGENTO_USER_PASS=$(awk -F "=" '/linux_magento_user_pass/ {print $2}' install.ini)
MAGENTO_CONNECT_PUBLIC_KEY=$(awk -F "=" '/magento_connect_public_key/ {print $2}' install.ini)
MAGENTO_CONNECT_PRIVATE_KEY=$(awk -F "=" '/magento_connect_private_key/ {print $2}' install.ini)
LANGUAGE_CODE=$(awk -F "=" '/language_code/ {print $2}' install.ini)
CURRENCY_CODE=$(awk -F "=" '/currency_code/ {print $2}' install.ini)
ADMIN_LOGIN_NAME=$(awk -F "=" '/admin_login_name/ {print $2}' install.ini)
ADMIN_LOGIN_PASS=$(awk -F "=" '/admin_login_pass/ {print $2}' install.ini)
ADMIN_EMAIL=$(awk -F "=" '/admin_email/ {print $2}' install.ini)
INSTALL_BASICS=$(awk -F "=" '/install_basics/ {print $2}' install.ini)
INSTALL_NGINX=$(awk -F "=" '/install_nginx/ {print $2}' install.ini)
INSTALL_APACHE=$(awk -F "=" '/install_apache/ {print $2}' install.ini)
INSTALL_MYSQL=$(awk -F "=" '/install_mysql/ {print $2}' install.ini)
INSTALL_PHP=$(awk -F "=" '/install_php/ {print $2}' install.ini)
INSTALL_MAILER=$(awk -F "=" '/install_mailer/ {print $2}' install.ini)
INSTALL_COMPOSER=$(awk -F "=" '/install_composer/ {print $2}' install.ini)
SWAPING_SETTINGS=$(awk -F "=" '/swaping_settings/ {print $2}' install.ini)
MAGENTO_CONNECT_KEY_STORING=$(awk -F "=" '/magento_connect_key_storing/ {print $2}' install.ini)
MAGENTO_WEBSERVER_CONFIG=$(awk -F "=" '/magento_webserver_config/ {print $2}' install.ini)
MAGENTO_DEPENDENCY_INJECTION=$(awk -F "=" '/magento_dependency_injection/ {print $2}' install.ini)
MAGENTO_INSTALLATION=$(awk -F "=" '/magento_installation/ {print $2}' install.ini)
MAGENTO_SAMPLE_DATA_INSTALLATION=$(awk -F "=" '/magento_sample_data_installation/ {print $2}' install.ini)

WAIT=6;

if [ $INSTALL_BASICS == "yes" ];
    then
        echo ""
        echo "INSTALLATION: BASIC LINUX PACKAGES"
        sleep $WAIT
        bash install/basics.sh
fi;

if [ $INSTALL_NGINX == "yes" ];
    then
        echo ""
        echo "INSTALLATION: NGINX WEB-SERVER"
        sleep $WAIT
        bash install/nginx.sh
fi;

if [ $INSTALL_APACHE == "yes" ];
    then
        echo ""
        echo "INSTALLATION: APACHE WEB-SERVER"
        sleep $WAIT
        bash install/apache.sh
fi;

if [ $INSTALL_MYSQL == "yes" ];
    then
        echo ""
        echo "INSTALLATION AND CONFIGURATION: MYSQL DATABASE AND SERVER"
        sleep $WAIT
        bash install/mysql.sh $DATABASE_NAME $DATABASE_PASS
fi;

if [ $INSTALL_PHP == "yes" ];
    then
        echo ""
        echo "INSTALLATION: FULL PHP 7"
        sleep $WAIT
        bash install/php7.sh
fi;

if [ $INSTALL_MAILER == "yes" ];
    then
        echo ""
        echo "INSTALLATION AND CONFIGURATION: POSTFIX EMAIL SENDER"
        sleep $WAIT
        bash install/postfix.sh $DOMAIN
fi;

if [ $INSTALL_COMPOSER == "yes" ];
    then
        echo ""
        echo "INSTALLATION: COMPOSER FOR PHP"
        sleep $WAIT
        bash install/composer.sh
fi;

if [ $SWAPING_SETTINGS == "yes" ];
    then
        echo ""
        echo "SETUP: LINUX SWAP MEMORY FOR UBUNTU 16"
        sleep $WAIT
        bash install/swap.sh
fi;

if [ $MAGENTO_WEBSERVER_CONFIG == "yes" ];
    then
        echo ""
        echo "CONFIGURATION: NGINX FOR MAGENTO 2"
        sleep $WAIT
        bash install/magento-prepare.sh $MAGENTO_RELEASE $DOMAIN $LINUX_MAGENTO_USER_NAME $LINUX_MAGENTO_USER_PASS
fi;

if [ $MAGENTO_CONNECT_KEY_STORING == "yes" ];
    then
        echo ""
        echo "CONFIGURATION: MAGENTO CONNECT KEYS"
        sleep $WAIT
        bash install/auth-json.sh $DOMAIN $MAGENTO_CONNECT_PUBLIC_KEY $MAGENTO_CONNECT_PRIVATE_KEY
fi;

if [ $MAGENTO_DEPENDENCY_INJECTION == "yes" ];
    then
        echo ""
        echo "INSTALLATION: MAGENTO 2 COMPOSER PROJECT"
        sleep $WAIT
        bash install/magento-injection.sh $DOMAIN
fi;

if [ $MAGENTO_INSTALLATION == "yes" ];
    then
        echo ""
        echo "INSTALLATION: THE MAGENTO 2"
        sleep $WAIT
        bash install/magento-install.sh $DOMAIN $BASE_URL $DATABASE_HOST $DATABASE_NAME $DATABASE_USER $DATABASE_PASS $ADMIN_EMAIL $ADMIN_LOGIN_NAME $ADMIN_LOGIN_PASS $LANGUAGE_CODE $CURRENCY_CODE
fi;

if [ $MAGENTO_SAMPLE_DATA_INSTALLATION == "yes" ];
    then
        echo ""
        echo "INSTALLATION: MAGENTO 2 SAMPLE DATA DEMO STORE"
        sleep $WAIT
        bash install/magento-sample.sh $DOMAIN $LANGUAGE_CODE
fi;
