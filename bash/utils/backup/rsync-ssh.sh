#!/bin/bash
. ~/.bashrc

CONFIG_PATH="${HOME}/.config"

if [ -f "${CONFIG_PATH}/rsync-ssh.conf" ]; then

    . ${CONFIG_PATH}/rsync-ssh.conf

    excludeFrom=''
    if [ -f "${CONFIG_PATH}/rsync-excludes.conf" ]; then
        excludeFrom="--exclude-from ${CONFIG_PATH}/rsync-excludes.conf"
    fi

    for directory in ${DIRECTORIES_SAVE[@]}; do
        # --backup --suffix=".rsync-backup" \
        rsync -a --stats --progress --delete --delete-excluded --force \
            ${excludeFrom} \
            ${directory} \
            -e ssh ${SSH}:${DESTINATION_PATH}${directory}
    done
else
    echo -e "SSH=''\nDESTINATION_PATH=''\nDIRECTORIES_SAVE=('')" > "${CONFIG_PATH}/rsync-ssh.conf"
    echo "Veuillez complèter le fichier ${CONFIG_PATH}/rsync-ssh.conf"
fi

