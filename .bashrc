# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=screen-256color
export H=/mnt/c/Users/brand

export PATH="~/bin:$PATH"
export PATH="~/.local/bin:$PATH"

if [ `hostname` == "captainJojo" ]; then
    export PATH="/usr/local/Cellar/python3/3.7.6_1/bin:$PATH"
fi

# export XDG_DATA_HOME="~/.local/share"

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

if [ -n $SSH_CLIENT ]; then
    PS1='\[\e[1;31m\][\D{%T}] \[\e[1;30m\]\$: \[\e[1;33m\]\w \[\e[1;30m\]\>\[\e[m\] '
else
    PS1='\[\e[1;35m\][\D{%T}] \[\e[1;30m\]\$: \[\e[1;33m\]\w \[\e[1;30m\]\>\[\e[m\] '
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

export VISUAL=nvim
# export PROMPT_DIRTRIM=2

# I love fzf...
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -l'

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview-window down:99% --preview 'if [ -d "{}" ]; then tree -C {} | head -200; else bat --color=always --line-range :500 {}; fi'"

if [ `hostname` == "captainJojo" ]; then
    export FZF_DEFAULT_OPTS="--color='bg:#f2f2de,bg+:#ffffea,info:#df8243,border:#acaa55,spinner:#df8243' \
                            --color='hl:#acaa55,fg:#181826,header:#acaa55,fg+:#121211' \
                            --color='pointer:#ff4c96,marker:#ef4cff,prompt:#ef4cff,hl+:#ef4cff' \
                            --bind=up:preview-up,down:preview-down"

    export BAT_THEME="Monokai Extended Light"
else
    export FZF_DEFAULT_OPTS="--color='bg:#4B4B4B,bg+:#3F3F3F,info:#BDBB72,border:#6B6B6B,spinner:#98BC99' \
                            --color='hl:#719872,fg:#D9D9D9,header:#719872,fg+:#D9D9D9' \
                            --color='pointer:#E12672,marker:#E17899,prompt:#98BEDE,hl+:#98BC99' \
                            --bind=up:preview-up,down:preview-down"

    export BAT_THEME="Monokai Extended Light"
fi
export FZF_DEFAULT_OPTS="--color='bg:#f2f2de,bg+:#ffffea,info:#df8243,border:#acaa55,spinner:#df8243' \
                        --color='hl:#acaa55,fg:#181826,header:#acaa55,fg+:#121211' \
                        --color='pointer:#ff4c96,marker:#ef4cff,prompt:#ef4cff,hl+:#ef4cff' \
                        --bind=up:preview-up,down:preview-down"

export BAT_THEME="Monokai Extended Light"

echo "-----------------"
echo "Going to init ssh"

function sshagent_export_if_exists {
    ssh-add -l &>/dev/null
    if [ "$?" == 2 ]; then
        test -r ~/.ssh-agent && \
            eval "$(<~/.ssh-agent)" >/dev/null

        ssh-add -l &>/dev/null
        if [ "$?" == 2 ]; then
            (umask 066; ssh-agent > ~/.ssh-agent)
            eval "$(<~/.ssh-agent)" >/dev/null
            ssh-add
        fi
    fi
}

sshagent_export_if_exists

echo "Finished"
echo "-----------------"
