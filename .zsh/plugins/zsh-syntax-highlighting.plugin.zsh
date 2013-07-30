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

    # bind UP and DOWN arrow keys
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
    bindkey "$terminfo[kcud1]" history-beginning-search-forward-end
    for keycode in '[' 'O'; do
          bindkey "^[${keycode}A" history-beginning-search-backward-end
          bindkey "^[${keycode}B" history-beginning-search-forward-end
    done
    unset keycode

    # bind P and N for EMACS mode
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down

    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
    echo '   loaded zsh-history-substring-search'
else
    echo '...skip zsh-history-substring-search'
fi
