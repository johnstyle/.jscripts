#!/bin/bash

# Utilisation :
# cp -f ~/Scripts/bashrc/bashrc.sh ~/.bashrc && source ~/.bashrc

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

# Custom prompt
if [ -f ~/Scripts/bashrc/prompt.sh ]; then
    . ~/Scripts/bashrc/prompt.sh
fi
