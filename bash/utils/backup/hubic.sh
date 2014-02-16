#!/bin/sh

#dbus=$(dbus-launch --sh-syntax | grep "DBUS_SESSION_BUS_ADDRESS='")
#eval ${dbus}

if [ "${1}" ] && [ "${2}" ]; then
    if [ $(ps -ef | grep -v grep | grep hubiC.exe | wc -l) -eq "0" ]; then
        hubic login $1 $2
        echo "Hubic est lancé !"
    else
        echo "Un processus est déjà en cours..."
    fi
else
    echo "Veuillez renseigner les paramètres <email> <folder to synchronize>"
fi
