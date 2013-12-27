#!/bin/bash

gitPrompt ()
{
    SFI="$IFS"
    IFS=/
    local path="$1"
    local tokens=($path)
    IFS="$SFI"
    local i=0
    local count=${#tokens[@]}
    while [ $i -lt $count ]
    do
        token="${tokens[$i]}"
        etoken="$token"
        if [ $i -gt 0 -o "$path" = / ]
        then
            printf /
            curpath="$curpath/"
        else
            if [ "$token" = "~" ]
            then
                etoken="$HOME"
            fi
        fi
        if [ "$token" ]
        then
            curpath="$curpath$etoken"
            printf "$token"
            cd "$etoken"
        else
            cd /
        fi
        if [ -e .git ]
        then
            gitstatus="$(gitStatus)"
            if [ "${gitstatus}" ]
            then
                printf "${Cyan} ${gitstatus}"
                if [ ${i} != $((${count}-1)) ]
                then
                    printf " ${Red}"
                fi
            fi
        fi
        i=$(($i+1))
    done
}

