#!/usr/bin/env sh
# Prints the Load Average and the Used Memory(%).

load=$(~/.tmux/tmux-powerline/segments/load.sh)
load=$(echo "$load" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//')
echo "(${load}) Ⓜ  $(used-mem)%"

exit 0
