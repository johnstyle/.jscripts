#!/bin/bash

gitStatusDeleted ()
{
    if [ ! "$1" ]; then
        $1=$(git status 2> /dev/null)
    fi

    [[ $($1 | grep "deleted:\|effacé :") != "" ]] && echo "-"
}

