#!/bin/bash/

# Modification des sources pour la version Jessie (Testing)
cp /etc/apt/sources.list /etc/apt/sources.list.save
cp config/etc/apt/sources.list /etc/apt/sources.list

# Mise à jour du système
apt-get update
apt-get dist-upgrade
apt-get autoremove
apt-get autoclean

# Installation :
apt-get install \

# - des logiciels de base
vim curl git \

# - du serveur web
apache2 php5 mysql-server libapache2-mod-php5 php5-mysql php5-curl php5-gd php-pear

# - des logiciels de sécurité
iptables fail2ban\

# Configuration du serveur web
cp config/etc/apache2/conf-available/charset.conf /etc/apache2/conf-available/charset.conf
cp config/etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf
a2enmod rewrite
a2enconf servername
service apache2 restart

# Configuration SSH
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.save
echo -e "--------------------------"
echo -e "Modifier :"
echo -e "--------------------------"
echo -e "Port xxxx"
echo -e "AllowUsers xxxx"
echo -e "PermitRootLogin no"
echo -e "Continuer"
read
vi /etc/ssh/sshd_config

# Configuration iptables
cp config/etc/init.d/firewall /etc/init.d/firewall
chmod +x /etc/init.d/firewall
echo -e "Modifier le port SSH par celui spécifié plus haut !"
read
vi /etc/init.d/firewall

# Configuration fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.conf.save

vi /etc/fail2ban/jail.conf.local
