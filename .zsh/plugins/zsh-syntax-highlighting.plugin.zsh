#
# zsh-syntax-highlighting
#
#  https://github.com/zsh-users/zsh-syntax-highlighting
#
[ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
    || { echo '...skip'; return; }

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#(main brackets pattern cursor)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

