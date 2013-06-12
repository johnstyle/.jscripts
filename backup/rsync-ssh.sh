#!/bin/bash
. ~/.bashrc

CONFIG_PATH="${HOME}/.config"

if [ -f "${CONFIG_PATH}/rsync-ssh.conf" ]; then

    . ${CONFIG_PATH}/rsync-ssh.conf

    for directory in ${DIRECTORIES_SAVE[@]}; do
        rsync -a --stats --progress --delete \
            --backup --suffix=".backup" \
            --filter "- lost+found/" \
            --filter "- .thumbnails/" \
            --filter "- .Trash/" \
            --filter "- .cache/" \
            --filter "- .beagle/" \
            --filter "- *.tmp" \
            --filter "- *.iso" \
            --filter "- *~" \
            --filter "- *.backup" \
            ${directory} \
            -e ssh ${SSH}:${DESTINATION_PATH}${directory}
    done
else
    echo -e "SSH=''\nDESTINATION_PATH=''\nDIRECTORIES_SAVE=('')" > "${CONFIG_PATH}/rsync-ssh.conf"
    echo "Veuillez complèter le fichier ${CONFIG_PATH}/rsync-ssh.conf"
fi

