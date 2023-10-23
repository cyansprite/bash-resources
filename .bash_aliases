# Don't you know ls aliases make the world go 'round?
alias k='kubectl'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias lp='ls -CF && tput setaf 11 && pwd'
alias :q=exit
alias so=source
alias :e=nvim $1
alias vnc=gvncviewer
alias gentags='ctags --fields=+l+a+K+m+n+S+z --excmd=number --format=2 --recurse --sort=yes --verbose=yes'
alias gencoretags='gentags --exclude="ui-glue-classic" --exclude="mock" --exclude="tests" --exclude="test" --exclude="automation" --exclude="testharness"'
alias genqttags='gentags --exclude="ui-glue-classic" --exclude="mock" --exclude="tests" --exclude="test" --exclude="automation" --exclude="testharness" --exclude="oe-logs" --exclude=oe-workdir'
alias fag='ag --nobreak --nonumbers --noheading . | fzf'
alias magic='tmux new-session -As MagicSpell'
alias shape='tmux new-session -As ShapeSpell'
alias v:='cd /mnt/v/'
alias c:='cd /mnt/c/'
alias weather='curl wttr.in/~lexington'
alias mux='tmux new-session -As MagicSpell'
alias fux='tmux new-session -As FocusSpell'
alias az=~/bin/az
alias python3=python3.9
alias c="bat --plain"
alias gits="git status --porcelain | cut --fields=3 --delimiter=' '"
alias bazel=bazelisk
alias less="less -R"
