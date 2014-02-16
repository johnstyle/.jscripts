#!/bin/bash/

# Installation
apt-get install curl git apache2 php5 mysql-server \
libapache2-mod-php5 php5-mysql php5-curl php5-gd php-pear \
apache2-suexec apache2-suexec-custom libapache2-mod-suphp


# Configuration apache2
cp -rf config/etc/apache2/* /etc/apache2/
if [ ! -f "/etc/apache2/suexec/www-data.save" ]; then
    cp /etc/apache2/suexec/www-data /etc/apache2/suexec/www-data.save
fi
cp config/etc/apache2/suexec/www-data /etc/apache2/suexec/www-data

a2dismod php5
a2enmod suexec
a2enmod suphp
a2enmod userdir
a2enmod rewrite
a2enconf servername
service apache2 restart
