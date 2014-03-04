#!/bin/bash/

# Installation
apt-get install curl git apache2 php5 mysql-server \
libapache2-mod-php5 php5-mysql php5-curl php5-gd php-pear \
apache2-suexec apache2-suexec-custom libapache2-mod-suphp \
nodejs nodejs-legacy npm


# Installation de bower
npm install -g bower


# Installation de composer
cd /tmp
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


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
