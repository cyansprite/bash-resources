# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=screen-256color
export H=/mnt/c/Users/brand

export DARK=1

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/lsp_servers/jdtls/bin:$PATH"
export PATH="$HOME/google/opt/google/chrome/google-chrome:$PATH"
export PATH="$HOME/.dotnet:$PATH"
export PATH="$HOME/home/brcoffman/bin/VSCode-linux-x64:$PATH"
export JDTLS_HOME="$HOME/.local/share/nvim/lsp_servers/jdtls"
export PATH="$PATH:/home/brcoffman/.dotnet/tools"

export PATH="$HOME/bin/godir/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GOROOT=/home/brcoffman/bin/godir/
export DOTNET_ROOT=$HOME/.dotnet

export EDITOR='nvim'
export VISUAL='nvim'

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
    # PS1='\[\e[1;9$(expr `date +%s` % 6 + 1)m\][\D{%T}] \[\e[1;3$(expr \( `date +%s` + 1 \) % 6 + 1)m\]\$: \[\e[1;93m\]\w \[\e[1;3$(expr \( `date +%s` + 1 \) % 6 + 1)m\]\>\[\e[m\] '
    PS1='\[\e[1;91m\][\D{%T}] \[\e[1;36m\]?:$(echo $?) \$: \[\e[1;93m\]\w \[\e[1;36m\]\>\[\e[m\] '
else
    PS1='\[\e[1;94m\][\D{%T}] \[\e[1;92m\]?:$(echo $?) \$: \[\e[1;93m\]\w \[\e[1;92m\]\>\[\e[m\] '
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

if [ -f ./.flutter_completions/flutter.bash_completions ]; then
    . ./.flutter_completions/flutter.bash_completions
fi

export VISUAL=nvim
# export PROMPT_DIRTRIM=2

# I love fzf...
export FZF_DEFAULT_COMMAND='ag -l'
export FZF_CTRL_T_COMMAND='ag -l'

export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="--height=80% --preview-window down:99% --preview 'if [ -d "{}" ]; then tree -C {} | head -200; else bat --color=always {}; fi'"

if [ $DARK == 1 ]; then
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#a6a476,bg:#121212,hl:#ff9900 --color=fg+:#79ada5,bg+:#2e2828,hl+:#f2ff00 --color=info:#afaf87,prompt:#ff0059,pointer:#ffffff --color=marker:#ff00dd,spinner:#00eaff,header:#54f000'
    export BAT_THEME="Monokai Extended"
else
    export FZF_DEFAULT_OPTS="--color='bg:#D5D2D9,bg+:#F5F2F9,info:#df8243,border:#acaa55,spinner:#df8243' \
                            --color='hl:#acaa55,fg:#181826,header:#acaa55,fg+:#121211' \
                            --color='pointer:#ff4c96,marker:#ef4cff,prompt:#ef4cff,hl+:#ef4cff' \
                            --bind=up:preview-up,down:preview-down"


    export BAT_THEME="Monokai Extended Light"
fi


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

if hash nvm 2>/dev/null; then
    nvm use node
fi

# enter blinking mode - red
export LESS_TERMCAP_mb=$'\e[00;31m'
# enter double-bright mode - bright cyan
export LESS_TERMCAP_md=$'\e[01;95m'
# enter standout mode - bright yellow
export LESS_TERMCAP_so=$'\e[01;93m'
# enter underline mode - underscore, bright cyan
export LESS_TERMCAP_us=$'\e[04;96m'

# turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_me=$'\e[0m'
# leave standout mode
export LESS_TERMCAP_se=$'\e[0m'
# leave underline mode
export LESS_TERMCAP_ue=$'\e[0m'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if hash kubectl 2>/dev/null; then
    source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
fi

# pnpm
export PNPM_HOME="/home/brcoffman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# avoid bloat but have the log in case something happens I care about
rm /home/brcoffman/.local/state/nvim/log


# Load Angular CLI autocompletion.
# source <(ng completion script)
