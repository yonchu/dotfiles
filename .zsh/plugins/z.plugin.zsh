#
# Z.sh
#
#  https://github.com/rupa/z
#
#  履歴を使ったディレクトリ移動
#  コマンド割り当て(j,c)
#
[ -x ~/.zsh/z/z.sh ] || { echo '...skip'; return; }

_Z_CMD=j
source ~/.zsh/z/z.sh

_z_cmd() { _z --add "$(pwd -P 2> /dev/null)"; }
add-zsh-hook precmd  _z_cmd

# TAB補完の機能をaliasにも追加
compctl -U -K _z_zsh_tab_completion $_Z_CMD

alias c='_z 2>&1'
alias jr='_z -r'

