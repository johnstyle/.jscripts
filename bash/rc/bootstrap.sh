#!/bin/bash

. ~/.jscripts/bash/libs/include.sh

# Chargement des couleurs
include ~/.jscripts/bash/colors.sh

# Chargement de la configuration par défaut
include ~/.jscripts/bash/rc/default/

# Chargement des alias
include ~/.jscripts/bash/rc/alias/

# Chargement des libraries
include ~/.jscripts/bash/libs/

# Root / User
if [ ! -z "${PS1_DEFAULT}" ]; then
    if [ "$USER" == "root" ]; then
        PS1_DEFAULT="${On_Red}${BWhite}[\h]${Color_Off} "
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

