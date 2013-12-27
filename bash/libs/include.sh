#!/bin/bash

function include ()
{
    if [ -f "$1" ]; then
        . "$1"
    elif [ -d "$1" ]; then
        for file in $(find $1 -name "*.sh"); do
            . "$file"
        done
    fi
}

