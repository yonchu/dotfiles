#!/usr/bin/env sh
# Prints the uptime.

uptime=$(~/.tmux/tmux-powerline/segments/uptime.sh)
uptime=$(echo "$uptime" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//')
echo "☝  $uptime"

exit 0
