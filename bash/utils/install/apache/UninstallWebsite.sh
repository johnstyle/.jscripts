#!/bin/bash

reset='\033[0m'
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

if [ "$(whoami)" = "root" ]; then

    echo -en "Nom de domaine : "
    read website
    if [ "${website}" ]; then

		defaultUser=$(echo ${website} | sed 's/\..*//g')
		
        echo -en "Nom d'utilisateur (${defaultUser}) : "
        read user
        if [ ! "${user}" ]; then
            user=${defaultUser}
        fi

        deluser ${user}
        rm -r ${user}/
        rm -r /home/git/repositories/websites/${user}/
        mysql -u root -p -e "DROP DATABASE ${user};"
        a2dissite ${website}
        rm /etc/apache2/sites-available/${website}
        service apache2 restart
	else
		echo -e "${red} - - - Veuillez renseigner un nom de domaine${reset}"
	fi
else
	echo -e "${red} - - - Vous devez être en ROOT${reset}"
fi
