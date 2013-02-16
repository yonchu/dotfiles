#
# Vim
#

if [ -x /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    # MacVim-Kaoriya
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vimm='/usr/bin/vim'
    #alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'
    alias view='vim -R'
elif type vim > /dev/null 2>&1; then
    alias vi='vim'
    alias view='vim -R'
else
    alias vim='vi'
fi

# エンコードを指定して開く
alias viwin='vim -c "edit ++fileformat=dos ++enc=cp932"'
alias vienc='vim -c "edit ++enc=euc-jp"'

# vim起動時にUniteをオープン
alias viu='vim -c "Unite -no-start-insert -no-split file_mru buffer file"'

# vim起動時にUnite(file=dotfiles)オープン
alias viud='vim -c "Unite -input=$HOME/dotfiles/. -no-start-insert -no-quit -winwidth=60 file"'

# vimをlessとして使う
if [ -x /Applications/MacVim.app/Contents/Resources/vim/runtime/macros/less.sh ]; then
    alias vless='/Applications/MacVim.app/Contents/Resources/vim/runtime/macros/less.sh'
elif [ -x /usr/share/vim/vim73/macros/less.sh ]; then
    alias vless='/usr/share/vim/vim73/macros/less.sh'
fi

# 全てのvimrcをviで編集
alias Ev='vi ~/dotfiles/.vimrc*'

# vim snippets 編集(Global)
alias snip='vi ~/.vim/snippets/_.snip'

# vim dict 編集
alias dict='vi ~/.vim/dict/_.dict'


#
# Personal settgins
#
# GTDを編集
function gtd() {
    if [ "$TMUX" ]; then
        # tmux実行時はタイトルを変更
        tmux rename-window "GTD"
    fi
    vi ~/Dropbox/Repos/markdown/gtd.txt
}

