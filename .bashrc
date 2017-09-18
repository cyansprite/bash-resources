# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=xterm-256color

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set prompt
PS1="\[$(tput setab 13)$(tput setaf 231)$(tput bold)\]$ > \[\033[00m\] "
# Set title
PS1="\[\e]0;\w\a\]$PS1"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# I like aliases :)
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

#enable adb autocompleter
if [ -e /bin/adb.txt ] ; then
    source /bin/adb.txt
fi

export VISUAL=nvim

# I love fzf...
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Fzf colors (note neovim is different)
# FZF_DEFAULT_OPTS="--color light,fg:138,bg+:235,fg+:189,hl:22,hl+:40,prompt:22,pointer:146,marker:182,spinner:197,header:181,info:159"
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
