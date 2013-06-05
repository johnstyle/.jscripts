#!/bin/bash

ABSPATH=$(dirname $(readlink -f $0))

if [ -f "${ABSPATH}/wgetrs.conf" ]; then
    . ${ABSPATH}/wgetrs.conf
fi

linkfile="${1}"

if [ ! -f "${linkfile}"]
then
    echo "Input file ${linkfile} not found. Exiting..."
fi

for i in rapidshare_cookie_tmp rapidshare_cookie
do
    if [ -f ~/.${i} ]
    then
        /bin/rm -f ~/.${i}
    fi
done

/usr/bin/wget wget -O ~/.rapidshare_cookie_tmp "https://api.rapidshare.com/cgi-bin/rsapi.cgi?sub=getaccountdetails&amp;withcookie=1&amp;login=${login}&amp;password=${password}"
grep "^cookie" ~/.rapidshare_cookie_tmp | awk -F'=' '{print $2}' &gt; ~/.rapidshare_cookie

wget -O ~/Téléchargements/ -c --no-cookies --header="Cookie: enc=`cat ~/.rapidshare_cookie`" -i "${linkfile}" -nc
