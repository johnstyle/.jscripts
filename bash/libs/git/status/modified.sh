#!/bin/bash

gitStatusModified ()
{
    if [ ! "$1" ]; then
        $1=$(git status 2> /dev/null)
    fi

    [[ $($1 | grep "renamed:\|modified:\|new file:\|renommé :\|modifié :\|nouveau :") != "" ]] && echo "*"
}

