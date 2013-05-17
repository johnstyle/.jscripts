#!/bin/bash

ABSPATH=$(dirname $(readlink -f $0))

if [ -f "${ABSPATH}/wget1f.conf" ]; then
    . ${ABSPATH}/wget1f.conf
fi

url=''
options=''

USER_AGENT="Mozilla/5.0 (Linux; U; Linux x86; fr-FR; rv:1.7.5) Gecko/20041202 Firefox/1.0"

cd ~/Téléchargements/

if [ "${1}" ]; then
    url="${1}"
elif [ -f "wget1f.txt" ]; then
    url="wget1f.txt"
    options=" -i "
fi

if [ "${url}" ]; then

    if [[ "${login}" && "${password}" ]]; then

        wget --quiet \
             --post-data "mail=${login}&pass=${password}&lt=on&valider=Envoyer" \
             --save-cookies wget1f.cookies \
             --keep-session-cookies \
             --user-agent "${USER_AGENT}" \
             -O /dev/null \
             "http://www.1fichier.com/login.pl"

        wget --load-cookies wget1f.cookies \
             --user-agent "${USER_AGENT}" \
             --content-disposition \
             -c \
             ${options} \
             "${url}"

        rm wget1f.cookies

    fi
else 
    echo "Veuillez renseigner un ou des URL à télécharger." 
fi

if [ -f "wget1f.txt" ]; then
    rm wget1f.txt
fi
