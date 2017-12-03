#!/bin/bash

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."

# -----------------------------------------------------------------------

alias :q="exit"
alias c="clear"
alias g="git"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias l='ls -l'
alias la='ls -la'
alias ll='ls -alF'
alias lsd="ls -l | grep --color=never '^d'"
alias q="exit"
alias rm="rm -rf --"
alias t="tmux"

# -----------------------------------------------------------------------

# Vim with no arguments (opens the current directory in Vim),
# otherwise opens the given argument.

v() {
	if [ $# -eq 0 ]; then
		vim .;
	else
		vim "$@";
	fi
}

# -----------------------------------------------------------------------

# Edit the hosts.

alias hosts="sudo vim /etc/hosts"

# -----------------------------------------------------------------------

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
