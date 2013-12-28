#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. ~/.jscripts/bash/libs/include.sh

# Chargement des couleurs
include ~/.jscripts/bash/colors.sh

# Chargement de la config
include ~/.jscripts/bash/rc/config.sh

# Chargement de la configuration par défaut
include ~/.jscripts/bash/rc/default/

# Chargement des alias
include ~/.jscripts/bash/rc/alias/

# Chargement des libraries
include ~/.jscripts/bash/libs/

# Root / User
if [ -z "${PS1_DEFAULT+set}" ]; then
    if [ "$USER" == "root" ]; then
        PS1_DEFAULT="${On_Red}${BWhite}\u@[\h]${Color_Off} "
    else
        PS1_DEFAULT="${On_Green}${BWhite}\u@[\h]${Color_Off} "
    fi
fi

# Git status
gitinfo=''
if [ $(which git) ]; then
    gitinfo='$(gitPrompt "\w")'
    gitinfo="${Red}${gitinfo}"
fi

# Prompt
PS1="${PS1_DEFAULT}${gitinfo}${Red} > ${White}"
