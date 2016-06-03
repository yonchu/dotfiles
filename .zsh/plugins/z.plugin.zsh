#
# z
#
#  https://github.com/knu/z
#
#  履歴を使ったディレクトリ移動
#  コマンド割り当て(j,c)
#
#    -c     restrict matches to subdirectories of the current directory
#    -e     echo the best match, don't cd
#    -h     show a brief help message
#    -l     list only
#    -r     match by rank only
#    -t     match by recent access only
#    -x     remove the current directory from the datafile

[ -f ~/.zsh/plugins/z/z.sh ] || { echo '...skip'; return; }

_Z_CMD=j
_Z_NO_COMPLETE_CD=1
source ~/.zsh/plugins/z/z.sh

# Define completion function to aliases.
compdef __z_cmd "$_Z_CMD"
compdef __z_cmd c

alias c='_z_cmd'

