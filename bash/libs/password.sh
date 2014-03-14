#!/bin/bash

function password ()
{
    if [[ "${1}" ]]; then
	length=12
        if [[ "${2}" ]]; then
            length=${2}
        fi
        echo "$(cat ~/.ssh/id_rsa)+${1}" | sha1sum | cut -c -${length}
    else
        echo 'Veuillez saisir la clé du mot de passe'
    fi
}
