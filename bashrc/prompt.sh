#!/bin/bash

__parse_git_deleted() {
  [[ $(git status 2> /dev/null | grep "deleted:") != "" ]] && echo "-"
}
__parse_git_added() {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
__parse_git_modified() {
  [[ $(git status 2> /dev/null | grep "renamed:\|modified:\|new file:") != "" ]] && echo "*"
}
__parse_git_notclean() {
  [[ $(git status 2> /dev/null | grep "nothing to commit") == "" ]] && echo "!"
}
__parse_git_dirty() {
  echo "$(__parse_git_notclean)$(__parse_git_added)$(__parse_git_modified)$(__parse_git_deleted)"
}
__parse_git_location() {
  location="unknow"
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(__parse_git_dirty)/")
  if [[ "${branch}" != "(no branch)" ]]; then
      location=${branch}
  else
      tag=$(git describe --tags 2> /dev/null)
      if [[ "${tag}" != "" ]]; then
          location="Tag:${tag}"
      else
          location="Commit:$(git rev-parse --short HEAD 2> /dev/null)"
      fi
  fi
  echo "(${location})"
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
            gitinfo="$(__parse_git_location)"
            if [ "${gitinfo}" ]
            then
                #last=${i}
                #printf "]"
                printf "${Cyan} ${gitinfo}"
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
PS1="${PS1}${Red}${gitinfo}${Red} > ${White}"
