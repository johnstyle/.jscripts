#!/bin/bash

ABSPATH=$(dirname $(readlink -f $0))

if [ -f "${ABSPATH}/backup.conf" ]; then

. ${ABSPATH}/backup.conf

currentDate=$(date "+%Y-%m-%d")
FTP_FILE=${FTP_FILE/'<date>'/${currentDate}}

tar -zcf ${TMP_FILE} ${DIRECTORIES_SAVE}

ftp -in <<EOF
  open ${FTP_HOST}
  user ${FTP_USER} ${FTP_PASS}
  bin
  verbose
  prompt
  put ${TMP_FILE} ${FTP_FILE}
  bye
EOF

rm ${BACKUP_FILE}

fi
