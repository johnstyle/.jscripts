#!/bin/bash
. ~/.bashrc

CONFIG_PATH="${HOME}/.config"
DEFAULT_LIST_FILE="wget1f.txt"

success=false

if [ "${1}" ]; then
    LIST_FILE=${1}
else
    LIST_FILE=${DEFAULT_LIST_FILE}
fi

function getCookie {
    if [ ! -f "${SCRIPT_PATH}/wget1f.cookies" ]; then
        wget --quiet \
             --post-data "mail=${LOGIN}&pass=${PASSWORD}&lt=on&valider=Envoyer" \
             --save-cookies "${SCRIPT_PATH}/wget1f.cookies" \
             --keep-session-cookies \
             --user-agent "${USER_AGENT}" \
             -O /dev/null \
             "http://www.1fichier.com/login.pl"
    fi
}

function download {
    response=$(wget --load-cookies "${SCRIPT_PATH}/wget1f.cookies" \
         --user-agent "${USER_AGENT}" \
         --content-disposition \
         --server-response \
         -c \
         "${1}" 2>&1 | grep "Enregistre :")
    filename=$(echo ${response} | sed -e 's/^.*«\(.*\)»$/\1/')
    log="$(date '+%Y-%m-%d %r') | ${1} | ${filename}"
    echo "${log}" >> "${SCRIPT_PATH}/${LIST_FILE}.log"
    echo "${log}"
    if [ -f "${DOWNLOAD_PATH}/${filename}" ]; then      
        success=true
    elif [ ! $(grep "Attention" "${DOWNLOAD_PATH}/index.html") ]; then
        success=true
    else
        success=false
    fi    
}

function removeLine {
    if [ -f "${LIST_FILE}" ]; then
        if [ ! -f "${SCRIPT_PATH}/${LIST_FILE}.lock" ]; then
            touch "${SCRIPT_PATH}/${LIST_FILE}.lock"
            sed "s~${1}~~g" ${LIST_FILE} > "${SCRIPT_PATH}/${LIST_FILE}.tmp"
            mv "${SCRIPT_PATH}/${LIST_FILE}.tmp" ${LIST_FILE}
            rm "${SCRIPT_PATH}/${LIST_FILE}.lock"
        else
            sleep 1
            removeLine ${1}
        fi
    fi
}

if [ -f "${CONFIG_PATH}/wget1f.conf" ]; then

    . ${CONFIG_PATH}/wget1f.conf

    if [ ! "${USER_AGENT}" ]; then
        USER_AGENT="Mozilla/5.0 (Linux; U; Linux x86; fr-FR; rv:1.7.5) Gecko/20041202 Firefox/1.0"
    fi

    if [ ! "${DOWNLOAD_PATH}" ]; then
        DOWNLOAD_PATH="${HOME}/Téléchargements"
    fi
    
    if [ ! -d "${DOWNLOAD_PATH}" ]; then
        mkdir ${DOWNLOAD_PATH}
    fi
    
    if [ -d "${DOWNLOAD_PATH}" ]; then
    
        cd ${DOWNLOAD_PATH}
        
        SCRIPT_PATH="${DOWNLOAD_PATH}/.wget1f"
        
        if [ ! -d "${SCRIPT_PATH}" ]; then
            mkdir ${SCRIPT_PATH}
        fi

        urls=()

        if [ -f "${LIST_FILE}" ]; then
            for line in $(cat ${LIST_FILE}); do
                if [ "${line}" ]; then
                    urls+=("${line}")
                fi
            done            
        fi

        if [ "${urls}" ]; then

            cp ${LIST_FILE} "${SCRIPT_PATH}/${LIST_FILE}.bk"

            getCookie

            for url in ${urls[@]}; do
                download ${url}
                if [[ "${success}" = true ]]; then
                    removeLine ${url}
                fi
            done
        else
            echo "Veuillez renseigner une URL"
        fi      
    else
        echo "Impossible d'acceder au dossier ${DOWNLOAD_PATH}"  
    fi
else
    echo "LOGIN=''\nPASSWORD=''\nDOWNLOAD_PATH=''\nUSER_AGENT=''" > "${CONFIG_PATH}/wget1f.conf"
    echo "Veuillez complèter le fichier ${CONFIG_PATH}/wget1f.conf"
fi

