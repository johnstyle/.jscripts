#!/bin/bash

gitStatusAdded ()
{
    if [ ! "$1" ]; then
        1=$(git status 2> /dev/null)
    fi

    [[ $(echo "$1" | grep "Untracked files:\|Fichiers non suivis:") != "" ]] && echo '+'
}
