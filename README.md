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
* Download this installer: `git clone https://github.com/DavidBelicza/magento2-server-configuration.git`
* Set your user names and passwords: `nano install.ini` or `gedit install.ini`
* Run the installer: `sudo bash install.sh`
* Now, you have an installed **Magento 2** prepared to development

## After Installation

The installation process created the Magento Linux User automatically, so you can login as Magento and use Magento's commands:
* `cd /var/www/html/mywebshop.com/webroot`
* `su magento`
* `php bin/magento`

If you have any permission issues use the following commands:
* `cd /var/www/html/mywebshop.com/webroot`
* `chown -R :www-data .`
* `find . -type d -exec chmod 770 {} \;`
* `find . -type f -exec chmod 660 {} \;`
* `chmod u+x bin/magento`

## Installation Demo

[![Magento 2 Installation - Full Server: Nginx, MySQL, PHP7, Sample Data](http://img.youtube.com/vi/Z34udaRg4mE/0.jpg)](http://www.youtube.com/watch?v=Z34udaRg4mE)

## Articles

Article about Magento 2 and Server installation in Hungarian: [Magento Propaganda](http://youama.hu/magento-propaganda/telepites-fejleszteshez-magento-2)
