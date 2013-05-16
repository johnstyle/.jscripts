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
apt-get autoremove --purge thunderbird empathy

# Installation des packets
# -------------------------------------------------
apt-get install \
apache2 php5 mysql-server libapache2-mod-php5 php5-mysql phpmyadmin git \
openjdk-7-jre \
vlc homebank chromium-browser calibre

# Nettoyage des packets
# -------------------------------------------------
apt-get autoremove --purge
apt-get clean

# Installation de l'IDE Aptana
# -------------------------------------------------
cd ~/Téléchargements/
wget http://download.aptana.com/studio3/standalone/3.4.0/linux/Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip
unzip Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip
mkdir /opt/aptana
mv Aptana_Studio_3/* /opt/aptana
rm Aptana_Studio_3_Setup_Linux_x86_64_3.4.0.zip

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

