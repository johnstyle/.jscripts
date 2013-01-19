#!/bin/bash

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green${White}
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

__parse_git_deleted() {
  [[ $(git status 2> /dev/null | grep "deleted:") != "" ]] && echo "-"
}
__parse_git_added() {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
__parse_git_modified() {
  [[ $(git status 2> /dev/null | grep "modified:\|new file:") != "" ]] && echo "*"
}
__parse_git_notclean() {
  [[ $(git status 2> /dev/null | grep "nothing to commit") == "" ]] && echo "!"
}
__parse_git_dirty() {
  echo "$(__parse_git_notclean)$(__parse_git_added)$(__parse_git_modified)$(__parse_git_deleted)"
}
__parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(__parse_git_dirty))/"
}
__git_bash_prompt() {
    SFI="$IFS"
    IFS=/
    local path="$1"
    local tokens=($path)
    IFS="$SFI"
    local i=0
    local count=${#tokens[@]}
    #local last=0
    #printf "["
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
            gitinfo="$(__parse_git_branch)"
            if [ "${gitinfo}" ]
            then
                #last=${i}
                #printf "]"
                printf "${Cyan}${gitinfo}"
                if [ ${i} != $((${count}-1)) ]
                then
                    printf " ${Red}"
                    #printf "[" 
                fi
            fi
        fi
        i=$(($i+1))
    done
    #if [ ${last} != $((${count}-1)) ]
    #then
    #    printf "]"
    #fi
}

gitinfo='$(__git_bash_prompt "\w")'
PS1="${BGreen}\u${Yellow}@\h ${Red}${gitinfo}${Red} > ${White}"
