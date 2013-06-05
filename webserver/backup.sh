#!/bin/bash

ABSPATH=$(dirname $(readlink -f $0))
TODAY=$(date --iso)

DEFAULT_TMP_DIR='/tmp/backup'
DEFAULT_MAX_DAYS=10

declare -A DIRECTORIES_SAVE

if [ -f "${ABSPATH}/backup.conf" ]; then

    . ${ABSPATH}/backup.conf

    if [ ! "${TMP_DIR}" ]; then
        TMP_DIR=${DEFAULT_TMP_DIR}
    fi
    
    if [ ! -d "${TMP_DIR}" ]; then
        mkdir ${TMP_DIR}
    fi

    if [ ! "${MAX_DAYS}" ]; then
        MAX_DAYS=${DEFAULT_MAX_DAYS}
    fi    

    OLDDAY=$(date --iso -d "${MAX_DAYS} days ago")

    if [ ! "${#DIRECTORIES_SAVE[@]}" ]; then
        DIRECTORIES_SAVE['backup']=(${DIRECTORIES_SAVE})
    fi

    if [ "${#DIRECTORIES_SAVE[@]}" -gt 0 ]; then

        for filename in "${!DIRECTORIES_SAVE[@]}"; do
            tar -zcf ${TMP_DIR}/${filename}.tar.gz ${DIRECTORIES_SAVE[${filename}]}
        done

        cd ${TMP_DIR}

        ftp -in <<EOF
          open ${FTP_HOST}
          user ${FTP_USER} ${FTP_PASS}
          bin
          verbose
          prompt
          cd ${OLDDAY}
          mdelete *
          cd ../
          rm ${OLDDAY}
          mkdir ${TODAY}
          cd ${TODAY}
          mput *
          bye
EOF

        rm ${TMP_DIR}/*
    else    
        echo "Veuillez renseigner les dossiers et fichiers à sauvegarder"
    fi
else
    echo "FTP_HOST=''
    FTP_USER=''
    FTP_PASS=''
    TMP_DIR='${DEFAULT_TMP_DIR}'
    MAX_DAYS=${DEFAULT_MAX_DAYS}
    DIRECTORIES_SAVE['backup']=''" > ${ABSPATH}/backup.conf
    echo "Veuillez renseigner le fichier ${ABSPATH}/backup.conf"
fi
