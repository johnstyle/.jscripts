#!/bin/bash/

# Installation
apt-get install gitweb


# Création de l'user git
if [ ! -d "/home/git/" ]; then
    useradd git
    mkdir /home/git/
    chown -R git:git /home/git/
    cp config/home/git/* /home/git/
fi


# Configuration SSH
if [ ! -f "/etc/ssh/sshd_config.save" ]; then
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.save
fi

echo -e "--------------------------"
echo -e "Modifier :"
echo -e "--------------------------"
echo -e " - AllowUsers xxxx git"
echo -e "Continuer"
read

vi /etc/ssh/sshd_config
