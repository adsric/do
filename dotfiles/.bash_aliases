#!/bin/bash

# -----------------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..="cd .."

# -----------------------------------------------------------------------

alias c="clear"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias l='ls -lFh'
alias la='ls -lAh'
alias duh='du -hs'
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"
alias :q="exit"
alias q="exit"
alias rm="rm -rf --"

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

alias edit-hosts="sudo vim /etc/hosts"

# -----------------------------------------------------------------------

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
