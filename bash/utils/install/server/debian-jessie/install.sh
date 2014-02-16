#!/bin/bash/

# Modification des sources pour la version Jessie (Testing)
if [ ! -f "/etc/apt/sources.list.save" ]; then
    cp /etc/apt/sources.list /etc/apt/sources.list.save
fi
cp config/etc/apt/sources.list /etc/apt/sources.list


# Mise à jour du système
apt-get update
apt-get dist-upgrade
apt-get autoremove
apt-get autoclean


# Installation
apt-get install vim iptables fail2ban


# Configuration SSH
if [ ! -f "/etc/ssh/sshd_config.save" ]; then
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.save
fi

echo -e "--------------------------"
echo -e "Modifier :"
echo -e "--------------------------"
echo -e " - Port xxxx"
echo -e " - AllowUsers xxxx"
echo -e " - PermitRootLogin no"
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
cp -rf config/etc/fail2ban/* /etc/fail2ban/

service fail2ban restart









# Redemarage des services
service iptables restart
service ssh restart
