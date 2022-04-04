# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=screen-256color
export H=/mnt/c/Users/brand

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/lsp_servers/jdtls/bin:$PATH"
export PATH="$HOME/google/opt/google/chrome/google-chrome:$PATH"
export JDTLS_HOME="$HOME/.local/share/nvim/lsp_servers/jdtls"


if [ `hostname` == "captainJojo" ]; then
    export PATH="/usr/local/Cellar/python3/3.7.6_1/bin:$PATH"
fi

# export XDG_DATA_HOME="$HOME/.local/share"

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
    PS1='\[\e[1;31m\][\D{%T}] \[\e[1;32m\]\$: \[\e[1;33m\]\w \[\e[1;32m\]\>\[\e[m\] '
else
    PS1='\[\e[1;35m\][\D{%T}] \[\e[1;32m\]\$: \[\e[1;33m\]\w \[\e[1;32m\]\>\[\e[m\] '
fi

# Set title
PS1="\[\e]0;\h:\u \j \!\a\]$PS1"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# I like aliases :)
if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
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
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -l'

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--height=80% --preview-window down:99% --preview 'if [ -d "{}" ]; then tree -C {} | head -200; else bat --color=always {}; fi'"

# export FZF_DEFAULT_OPTS="--color='bg:#f2f2de,bg+:#ffffea,info:#df8243,border:#acaa55,spinner:#df8243' \
                        # --color='hl:#acaa55,fg:#181826,header:#acaa55,fg+:#121211' \
                        # --color='pointer:#ff4c96,marker:#ef4cff,prompt:#ef4cff,hl+:#ef4cff' \
                        # --bind=up:preview-up,down:preview-down"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#a6a476,bg:#121212,hl:#ff9900 --color=fg+:#79ada5,bg+:#2e2828,hl+:#f2ff00 --color=info:#afaf87,prompt:#ff0059,pointer:#ffffff --color=marker:#ff00dd,spinner:#00eaff,header:#54f000'

export BAT_THEME="Monokai Extended"

echo "-----------------"
echo "Going to init ssh"

function sshagent_export_if_exists {
    ssh-add -l &>/dev/null
    if [ "$?" == 2 ]; then
        test -r $HOME/.ssh-agent && \
            eval "$(<$HOME/.ssh-agent)" >/dev/null

        ssh-add -l &>/dev/null
        if [ "$?" == 2 ]; then
            (umask 066; ssh-agent > $HOME/.ssh-agent)
            eval "$(<$HOME/.ssh-agent)" >/dev/null
            ssh-add
        fi
    fi
}

sshagent_export_if_exists

echo "Finished"
echo "-----------------"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/brcoffman/bin

source '/home/brcoffman/lib/azure-cli/az.completion'

if [ -x /usr/bin/remind ]; then
    remind ~/.reminders
fi

nvm use default
