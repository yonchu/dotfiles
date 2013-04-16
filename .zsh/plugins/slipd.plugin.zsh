#
# slipd
#
#  https://github.com/pasberth/slipd
#

[ -f ~/.zsh/plugins/slipd/slipd.sh ] || { echo '...skip'; return; }

source ~/.zsh/plugins/slipd/slipd.sh

alias ..=slipd
compdef _slipd ..
