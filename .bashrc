#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# -----------------------------------------------------------------------

# If not running interactively, don't do anything

case $- in
	*i*) ;;
	  *) return;;
esac

# -----------------------------------------------------------------------

# make less more friendly for non-text input files, see lesspipe(1)

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------------------------------------------------

[ -n "$PS1" ] \
	&& . ~/.bash_profile
