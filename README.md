# Magento 2 Automatized Server Configurator

This script installs the Magento and its server environment. It installs **Nginx**, **PHP7**, **MySQL**, **Postfix**, **Composer**, **Magento 2**, **Magento sample data** and all
required packages and dependencies. It also set the **Linux swapping** and **Vhost configuration**.

This script makes ready Magento 2 to work for development and sets a single one store for one website.

This Magento environment fine for module and template development and Magento core contribution development

Pre-requirements: Ubuntu 16 with Internet connection.

To install Magento, first fill out the install.ini file then run the command "sudo bash install.sh"

## Guide

* Get an Ubuntu 16
* Update it: `sudo apt-get update`
* Install git: `sudo apt-get install git`
* Download this isntaller: `git clone https://github.com/DoveID/magento2-server-configuration.git`
* Set your user names and passwords: `nano install.ini` or `gedit install.ini`
* Run the installer: `sudo bash install.sh`
* Now, you have an installed **Magento 2** prepared to development
