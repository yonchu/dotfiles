#
# slipd
#
#  https://github.com/pasberth/slipd
#

[ -f ~/.zsh/slipd/slipd.sh ] || { echo '...skip'; return; }

source ~/.zsh/slipd/slipd.sh

alias ..=slipd
compdef _slipd ..
