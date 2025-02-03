# ~/.bashrc: executed by bash(1) for non-login shells.
export TERM=screen-256color
export H=/mnt/c/Users/brand

export DARK=1

export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"
export PATH="$HOME/tools/kotlin-language-server/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/snap/bin/:$PATH"
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
shopt -s expand_aliases
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
export FZF_DEFAULT_COMMAND='ag -l | sort -u -r'
export FZF_CTRL_T_COMMAND='ag -l | sort -u -r'
export FZF_ALT_C_COMMAND="ag --null -g ./ | xargs -0 dirname | sort -u -r"
export FZF_CTRL_T_OPTS='--height=75% --preview-window "right:57%" --preview "if [ -d {} ]; then tree -C {} | head -200; else bat --color=always {}; fi" --bind alt-u:preview-half-page-up,alt-d:preview-half-page-down,ctrl-y:preview-up,ctrl-e:preview-down'
# export FZF_ALT_C_OPTS='--walker-skip .git,node_modules,target --height=50% --preview-window "right:57%" --preview "if [ -d {} ]; then tree -C {} | head -201; else bat --color=always {}; fi" --bind alt-u:preview-half-page-up,alt-d:preview-half-page-down,ctrl-y:preview-up,ctrl-e:preview-down'
export FZF_ALT_C_OPTS='--walker-skip .git,node_modules,target --height=50% --preview-window "right:57%" --preview "if [ -d {} ]; then tree -C {} | head -201; else ls {}; fi" --bind alt-u:preview-half-page-up,alt-d:preview-half-page-down,ctrl-y:preview-up,ctrl-e:preview-down'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5fb0a8,hl+:#00ffcc,info:#afaf87,marker:#87ff00
  --color=prompt:#ff0073,spinner:#ffd15e,pointer:#ffdc5e,header:#87afaf
  --color=gutter:#292929,border:#393939,separator:#666666,scrollbar:#7b7b7b
  --color=label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
# export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS --bind 'ctrl-s:execute: cacheAdd.sh {}'   --header 'CTRL-s (save to cache)'"

if [ $DARK == 1 ]; then
    export BAT_THEME="ansi"
else
    export BAT_THEME="ansi"
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

if hash sdk 2>/dev/null; then
    sdk use java 17.0.3-zulu
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

source ~/.fzf/bin/fzf-git.sh

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

pods() {
  command='kubectl get pods --all-namespaces' fzf \
    --info=inline --layout=reverse --header-lines=1 \
    --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
    --header $'╱ Enter (show logs in bash instead of preview) ╱ CTRL-O (TBD (same as enter)) ╱ CTRL-R (reload) ╱\n\n' \
    --bind 'start:reload:tmux display-message "loading";$command;tmux display-message "done";' \
    --bind 'ctrl-r:reload:tmux display-message "loading";$command;tmux display-message "done";' \
    --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
    --bind 'ctrl-o:execute:klogs --namespace {1} --pod {2} --since 10000h' \
    --bind 'enter:execute:klogs --namespace {1} --pod {2} --since 10000h' \
    --preview-window up:follow \
    --preview 'klogs --namespace {1} --pod {2} --since 10000h' "$@"
}
# --bind 'enter:execute:hash={2} && echo "kubectl debug --namespace {1} {2} --image=onelexcloudregistry.azurecr.io/iss-base-images/iss-base:debian-slim --target \"${hash%-*}\" -- bash"' \

# if directory doesn't exist
if [ ! -d "$HOME/cache" ]; then
  mkdir -p "$HOME/cache"
fi

# if file does not exist
if [ ! -f "$HOME/cache/commands.sh" ]; then
  touch "$HOME/cache/commands.sh"
fi

cacheFi="$HOME/cache/commands.sh"
function cacheRemove() {
  fi="$cacheFi"
  grep -v "$@" "$fi" > "$fi.tmp"
  mv "$fi.tmp" "$fi"
}

function cacheAdd() {
  echo "$@" | sed 's/^\w\+\s\+//g' >> ~/cache/commands.sh
  sort -u -o ~/cache/commands.sh.tmp < ~/cache/commands.sh
  mv ~/cache/commands.sh.tmp ~/cache/commands.sh
}

function cacheShow() {
  # eval, remove cacheShow last entry from /home/brcoffman/.bash_history && add
  # {} to /home/brcoffman/.bash_history
  command='cat /home/brcoffman/cache/commands.sh' \
    fzf --height 20% \
    --header $'╱ CTRL-x (Delete entry from command cache) ╱ CTRL-R (reload) ╱\n\n' \
    --bind 'start:reload:$command' \
    --bind 'ctrl-r:reload:$command' \
    --bind 'ctrl-x:execute:source /home/brcoffman/.bashrc && cacheRemove.sh {}' \
    --bind 'enter:become(echo {}; eval {})'
}

gco() {
  gits | fzf --multi --preview 'git diff --color=always {}' --preview-window=down:70% --bind 'enter:become:git checkout {}'
}

# TODO figure out why this doesn't work in FZF land
export -f cacheAdd
export -f cacheRemove
export -f cacheShow
export KUBE_EDITOR=nvim

# trying this out.. it's.. interesting
source ~/.fzf/bash-completion
bind -x '"": fzf_bash_completion'
export FZF_COMPLETION_AUTO_COMMON_PREFIX=false
export FZF_COMPLETION_AUTO_COMMON_PREFIX_PART=false
ulimit -n 2048

# if argocd is installed setup completion
if hash argocd 2>/dev/null; then
  # check if file exists
  if [ ! -f .completions/argocd_completions ]; then
    # check if dir exists
    if [ ! -d .completions ]; then
      mkdir .completions
    fi
    argocd completion bash > .completions/argocd_completions
  fi

  source $HOME/.completions/argocd_completions
fi
