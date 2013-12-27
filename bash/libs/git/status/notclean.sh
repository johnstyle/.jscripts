#!/bin/bash

gitStatusNotClean ()
{
    if [ ! "$1" ]; then
        $1=$(git status 2> /dev/null)
    fi

    [[ $($1 | grep "nothing to commit\|rien à valider") == "" ]] && echo "!"
}
