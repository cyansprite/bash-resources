# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=xterm-256color
export H=/mnt/c/Users/bcoffman

alias ls='ls -G'
alias l='ls -CF'

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
HISTFILESIZE=9999

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set prompt if ssh use orange-white, otherwise use magenta-black
if [ -n "$SSH_CLIENT" ]; then
    PS1='\[\e[1;36m\]\$:\[\e[1;33m\]\[\e[1;35m\]\w \[\e[7;33m\]\[\e[1;36m\]\>\[\e[m\] '
else
    PS1='\[\e[1;36m\]\$:\[\e[1;35m\]\w \[\e[1;36m\]\>\[\e[m\] '
fi
# Set title
PS1="\[\e]0;\h:\u \j \!\a\]$PS1"

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
# export PROMPT_DIRTRIM=2

# I love fzf...
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Setting fd as the default source for fzf

if hash ag 2>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -l'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# export FZF_CTRL_T_OPTS="--preview-window down:50% --preview '(cat {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_DEFAULT_OPTS="--color 16"
# export FZF_COMPLETION_TRIGGER='\\'
# export FZF_DEFAULT_COMMAND='ag -l'
# export DISPLAY=:0

echo "-----------------"
echo "Going to init ssh"

function sshagent_export_if_exists {
    SSH_AGENT=`find /tmp -uid $(id -u) -type s -name agent.\* 2>/dev/null`
    echo 'We go this agent :: ' $SSH_AGENT

    if [ $? ] ; then
        export SSH_AUTH_SOCK=$SSH_AGENT
        ssh-add -l
    fi
}

sshagent_export_if_exists

echo "Finished"
echo "-----------------"
