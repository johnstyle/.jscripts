#!/bin/bash

# Colors
if [ -f ~/Scripts/bashrc/colors.sh ]; then
    . ~/Scripts/bashrc/colors.sh
fi

# Settings
if [ -f ~/Scripts/bashrc/settings.sh ]; then
    . ~/Scripts/bashrc/settings.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Custom alias
if [ -f ~/Scripts/bashrc/alias.sh ]; then
    . ~/Scripts/bashrc/alias.sh
fi

# User et host
if [ ! "${PS1}" ]; then
    if [ "$USER" == "root" ]; then
        PS1="${On_Green}${BWhite}[\h]${Color_Off} "
    else
        PS1="${On_Green}\u@[\h]${Color_Off} "
    fi
fi

# Custom prompt
if [ -f ~/Scripts/bashrc/prompt.sh ]; then
    . ~/Scripts/bashrc/prompt.sh
fi
