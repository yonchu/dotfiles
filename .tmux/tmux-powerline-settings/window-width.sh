# Prints the current window width.

if [ -n "$TMUX" ]; then
    tmux display -p "#{window_width}"
else
    echo "$COLUMNS"
fi
exit 0
