#!/bin/bash

if [ -z "$JSCRIPTS_BASE" ]; then
    JSCRIPTS_BASE="${HOME}/.jscripts/"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

. "${JSCRIPTS_BASE}bash/libs/include.sh"

# Chargement des couleurs
include "${JSCRIPTS_BASE}bash/colors.sh"

# Chargement de la config
include "${JSCRIPTS_BASE}rc/config.sh"

# Chargement de la configuration par défaut
include "${JSCRIPTS_BASE}rc/default/"

# Chargement des alias
include "${JSCRIPTS_BASE}bash/rc/alias/"

# Chargement des libraries
include "${JSCRIPTS_BASE}bash/libs/"

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

