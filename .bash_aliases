# Don't you know ls aliases make the world go 'round?
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias lp='ls -CF && tput setaf 11 && pwd'
alias :q=exit
alias so=source
alias :e=nvim $1
alias vnc=gvncviewer
alias gentags='ctags-exuberant --fields=+l+a+K+m+n+S+z --excmd=number --format=2 --recurse --sort=yes --verbose=yes'
alias gencoretags='gentags --exclude="ui-glue-classic" --exclude="mock" --exclude="tests" --exclude="test" --exclude="automation" --exclude="testharness"'
alias fag='ag --nobreak --nonumbers --noheading . | fzf'
alias apt='sudo apt'
alias magic='tmux new-session -As MagicSpell'
alias v:='cd /mnt/v/'
alias c:='cd /mnt/c/'
alias weather='curl wttr.in/~lexington'
