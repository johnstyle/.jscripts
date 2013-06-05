#!/bin/bash

# Mep bashrc
# -------------------------------------------------
if [ -f "${HOME}/Scripts/bashrc/bashrc.sh" ]; then
    cp -f ${HOME}/Scripts/bashrc/bashrc.sh ${HOME}/.bashrc
    source ${HOME}/.bashrc
fi

# Maj des packets
# -------------------------------------------------
apt-get update

# Suppression des packets
# -------------------------------------------------
apt-get autoremove --purge thunderbird empathy empathy-common unity-lens-shopping

# Installation des packets
# -------------------------------------------------
apt-get install \
apache2 php5 mysql-server libapache2-mod-php5 php5-mysql php5-curl phpmyadmin git gftp \
openjdk-7-jre vim curl ssh samba \
vlc homebank chromium-browser calibre keepassx hplip pidgin skanlite

# Nettoyage des packets
# -------------------------------------------------
apt-get autoremove --purge
apt-get clean

# Installation de l'IDE Aptana
# -------------------------------------------------
if [ -f "/usr/share/applications/aptana.desktop" ]; then
    cd ~/Téléchargements/
    wget http://download.aptana.com/studio3/standalone/3.4.0/linux/Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip
    unzip Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip
    mkdir /opt/aptana
    mv Aptana_Studio_3/* /opt/aptana
    rm Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip
    rm -r Aptana_Studio_3/

if [ -f "/usr/share/applications/aptana.desktop" ]; then
echo "[Desktop Entry]
Name=Aptana Studio
Comment=An IDE for web applications projects
Comment[fr]=Un IDE pour réaliser des projets d'applications web
Icon=/opt/aptana/icon.xpm
Exec='/opt/aptana/AptanaStudio3'
Type=Application
Categories=Application;GTK;Development;IDE;
Encoding=UTF-8
StartupNotify=false" > /usr/share/applications/aptana.desktop
fi
fi

# Configuration du serveur web
# -------------------------------------------------
chmod -R 777 /var/www/

if [ -f "/etc/apache2/conf.d/httpd.conf" ]; then
	echo "DirectoryIndex index.html index.htm index.xhtml index.php
ServerName localhost" > /etc/apache2/conf.d/httpd.conf
fi
