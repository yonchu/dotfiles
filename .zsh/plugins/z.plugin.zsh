#
# z
#
#  https://github.com/knu/z
#
#  履歴を使ったディレクトリ移動
#  コマンド割り当て(j,c)
#
#    -h  show this help
#    -c  restrict matches to subdirectories of the current directory
#    -l  list dirs (matching args if given)
#    -r  sort dirs by rank
#    -t  sort dirs by recency

[ -f ~/.zsh/z/z.sh ] || { echo '...skip'; return; }

_Z_CMD=j
_Z_NO_COMPLETE_CD=1
source ~/.zsh/z/z.sh

# Define completion function to aliases.
compdef __z_cmd "$_Z_CMD"
compdef __z_cmd c

alias c='_z_cmd'
alias jr='_z_cmd -r'

