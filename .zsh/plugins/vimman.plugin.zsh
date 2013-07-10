#
# vimman
#
#  https://github.com/yonchu/vimman
#

[ -f ~/.zsh/plugins/vimman/vimman.zsh ] || { echo '...skip'; return; }

source ~/.zsh/plugins/vimman/vimman.zsh

zstyle ':vimman:' dir ~/.vim/bundle
zstyle ':vimman:' expire 7
zstyle ':vimman:' verbose yes
