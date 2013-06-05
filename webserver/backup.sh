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

    if [ ! "${#DIRECTORIES_SAVE[@]}" ]; then
        DIRECTORIES_SAVE['backup']=(${DIRECTORIES_SAVE})
    fi

    if [ "${#DIRECTORIES_SAVE[@]}" > 0 ]; then

        files=()

        for filename in "${!DIRECTORIES_SAVE[@]}"; do

            file="${filename}.tar.gz"

            tar -zcf ${TMP_DIR}/${file} ${DIRECTORIES_SAVE[${filename}]}

            files+=(${file})
        done

        ftp -in <(
          echo "open ${FTP_HOST}"
          echo "user ${FTP_USER} ${FTP_PASS}"
          echo "bin"
          echo "verbose"
          echo "prompt"
         
          # Suppression des vielles archives
          if [ "${MAX_DAYS}" ]; then
            oldday=$(date --iso -d "${MAX_DAYS} days ago")
            echo "rm -r ${oldday}"
          fi
          
          echo "mkdir ${TODAY}"
          echo "cd ${TODAY}"
          
          # Envoi des nouvelles archives
          for file in "${files[@]}"; do
            echo "put ${TMP_DIR}/${file} ${file}"
          done

          echo "bye"
        )

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
