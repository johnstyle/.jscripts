#!/bin/bash

function rmFiles ()
{
    if [[ "${1}" ]]; then
        if [[ "${1}" = '-h' ]]; then
            echo -e "rm-files()\n"
            echo -e "NAME"
            echo -e "    rm-files - Recursively delete files in the current folder by name and modification date.\n"
            echo -e "SYNOPSIS"
            echo -e "    rm-files [filename] [days]\n"
            echo -e "OPTIONS"
            echo -e "    1. The pattern of files names searched. ex: *.sql"
            echo -e "    2. The modification date of files less than x days. ex: 3"
        else
            if [[ "${2}" ]]; then
                mtime="-mtime +${2}"
            else
                mtime=""
            fi
            find . -type f -name "${1}" ${mtime} -exec rm -f {} \;
        fi
    fi
}

