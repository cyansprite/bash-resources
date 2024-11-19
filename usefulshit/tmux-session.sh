#!/bin/sh
# Usage: tmux-session.sh <session-name>
# Draw a tmux session with 3 windows:
#
# Screen layout:
# =====================
# 0: UI
# -------------------
# Builder
# -------------------
# Console
#
#
#
#
# -------------------
#
# =====================
# 1: SVC
# -------------------
# Main
#
#
#
#
#
# -------------------
#
# =====================
# 2: BUILD
# -------------------
# Builder
#
# -------------------
# Builder 2
#
# -------------------
# Finder
#
# -------------------


session=$1
if [ -z "$session" ]; then
    echo "Usage: $0 <session-name>"
    exit 1
fi

# Build UI
tmux new-session -s "$session" -n UI -d 'cd ~/code/config/connected-device-ui; bash -i'
tmux split-window -v -t "$session":0 -d 'cd ~/code/config/connected-device-ui; bash -i'
tmux resize-pane -t "$session":0 -y 10

# Build SVC
tmux new-window -t "$session":1 -n SVC -d 'cd ~/code/config/connected-device-service; bash -i'

# Build Building
tmux new-window -t "$session":2 -n BUILD -d 'cd ~/code/yggdrasil; bash -i'
tmux select-window -t "$session":2
tmux select-pane -t 0
tmux split-window -v -t "$session":2 -d 'cd ~/code/yggdrasil; bash -i'
tmux select-pane -t 1
tmux split-window -v -t "$session":2
tmux select-pane -t 0
tmux select-layout even-vertical

tmux -2 attach-session -t "$session"
