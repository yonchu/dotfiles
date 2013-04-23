#
# zsh-syntax-highlighting
#
#  https://github.com/zsh-users/zsh-syntax-highlighting
#

if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    #(main brackets pattern cursor)
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
    echo '   loaded zsh-syntax-highlighting'
else
    echo '...skip zsh-syntax-highlighting'
fi


#
# zsh-history-substring-search
#
#  https://github.com/zsh-users/zsh-history-substring-search
#
#  This is a clean-room implementation of the Fish shell's history search feature,
#  where you can type in any part of any previously entered command and press
#  the UP and DOWN arrow keys to cycle through the matching commands.
#  You can also use K and J in VI mode or ^P and ^N in EMACS mode for the same.
#

if [ -f ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=black,bold'
    # HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
    # HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
    echo '   loaded zsh-history-substring-search'
else
    echo '...skip zsh-history-substring-search'
fi
