#*******************************************************************************
#
#  .profile
#
#    環境変数などの設定(OS共通, bash/zsh共通)
#
#*******************************************************************************

#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
        # rootユーザの場合
        # http://news.mynavi.jp/column/zsh/024/index.html
        LANG=C
        ;;
esac


#
# User Local Directory
#
USER_LOCAL=/usr/local
if type brew > /dev/null 2>&1; then
    USER_LOCAL=$(brew --prefix)
fi
export USER_LOCAL


#
# Terminal configuration
# http://journal.mycom.co.jp/column/zsh/009/index.html
#
unset LSCOLORS
case "${TERM}" in
    xterm)
        # オリジナルのTERM=xtermはカラー表示できない
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-color
        # set BackSpace control character
        stty erase
        ;;
esac

case "${TERM}" in
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        ;;
    kterm*|xterm*|screen*)
        # lsのカラー化
        export CLICOLOR=1
        export LSCOLORS=DxGxcxdxCxegedabagacad

        # glsのカラー化
        #  color-ls の色を設定する fi=37(バックグラウンド黒の場合)
        LS_COLORS="di=01;33:ex=01;36:ln=01;32:bd=35:cd=35:pi=32:so=32:su=41;30:sg=46;30:tw=42;30:ow=43;30"
        LS_COLORS="$LS_COLORS:*.gz=31:*.Z=31:*.lzh=31:*.zip=31:*.bz2=31"
        LS_COLORS="$LS_COLORS:*.tar=31:*.tgz=31"
        LS_COLORS="$LS_COLORS:*.gif=35:*.jpg=35:*.jpeg=35:*.tif=35:*.ps=35"
        LS_COLORS="$LS_COLORS:*.xpm=35:*.xbm=35:*.xwd=35:*.xcf=35"
        LS_COLORS="$LS_COLORS:*.avi=35:*.mov=35:*.mpeg=35:*.mpg=35"
        LS_COLORS="$LS_COLORS:*.mid=35:*.MID=35:*.rcp=35:*.RCP=35:*.mp3=35"
        LS_COLORS="$LS_COLORS:*.mod=35:*.MOD=35:*.au=35:*.aiff=35:*.wav=35"
        LS_COLORS="$LS_COLORS:*.htm=32:*.html=32:*.xml=32:*.java=32:*.class=32"
        LS_COLORS="$LS_COLORS:*.c=32:*.h=32:*.C=32:*.c++=32:*.conf=32"
        LS_COLORS="$LS_COLORS:*.tex=32:*~=0"
        export LS_COLORS
        ;;
esac


#
# 端末XON/XOFF制御を無効
#  vimなどでC-s/C-qを使用するため
#  ただし、C-s/C-qによる画面停止/再開が行えなくなる
#  http://www.akamoz.jp/you/uni/shellscript.htm
#  http://d.hatena.ne.jp/ksmemo/20110214/p1
#
if [ -t 0 ]; then
    stty -ixoff -ixon
fi


#
# history setting
#
HISTSIZE=10000              # ヒストリに保存するコマンド(メモリ)
HISTFILESIZE=100000         # ヒストリに保存するコマンド(ファイル)
HISTCONTROL=ignoredups      # 入力が最後のヒストリと一致する場合は記録しない
HISTTIMEFORMAT='%Y-%m-%d %T '
export HISTSIZE HISTFILESIZE HISTCONTROL HISTTIMEFORMAT


#
# PAGER
#
export PAGER=less

# lessのデフォルトオプションを設定
#  -F or --quit-if-one-screen  1画面で表示できる場合はそのままコマンド終了
#  -R ANCIエスケープシーケンスを解釈(主にカラー表示を有効に)
#  -X, --no-init 終了後に画面をクリアしない
#  -i, --ignore-case 検索時に大文字小文字を区別しない
#  -xn, --tabs=n タブストップをn文字に
#  --LONG-PROMPT プロンプトを詳細表示に
#  -P プロンプトのフォーマットを変更
#export LESS='-R -X -i -x4 -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
export LESS='-R -X -i -x4 --LONG-PROMPT'

#export JLESSCHARSET=utf-8
export JLESSCHARSET=japanese-utf-8
export LESSCHARSET=utf-8
#export GIT_PAGER="lv -c -l"
export GIT_PAGER="less -F"


#
# デフォルトエディタ
#
export EDITOR=vim
export VISUAL=vim


#
# grep
#
# オプション
#  -i 大文字小文字を区別しない
#  -n 各行の先頭にファイルの行番号を表示します
#  -H ファイル名を表示
#  -E オプションは、拡張正規表現を使用する場合に指定
#     fgrep 正規表現を使わない検索
#     egrep 正規表現を使った検索 -E と同じ
#  -R, -r, --recursive ディレクトリを再帰的にたどる
#  -I バイナリ検索除外
#  -w 単語マッチ
#  --color=[WHEN]
#     always: パイプ使用時に強制的にカラーコードをつける
#     auto : 出力先に応じて判断 - パイプ時などはカラーコードをつけない
#     never : カラーコードOFF
#  --directories=skip ディレクトリを無視
#
# GREP_OPTIONS
#   他コマンドで使用しているgrepにも影響が出るため注意
GREP_OPTIONS="-I --directories=skip --color=auto"
export GREP_OPTIONS

# 検索ワードを色付け
#    1:bold
#   37:フォアグランドを白
#   41:バックグラウンドを赤
export GREP_COLOR='1;37;41'


#
# BLOCKSIZE
#  df・du コマンドなどが参照するブロックサイズ(デフォルト512バイト)
#  k: 1キロバイト単位
#
export BLOCKSIZE=k


#
# rsync
#  RSYNC_PASSWORDを使うと、自動でパスワードを入力できる
#  便利だけど危険
#  rsync では ssh を使う
#
#export RSYNC_PASSWORD=xxxx
export RSYNC_RSH=ssh


#
# tree
#  文字コード、ロケールを設定
export TREE_CHARSET='UTF-8'
export LC_CTYPE='ja_JP.UTF-8'


#
# CVS
#  cvs では ssh を使う
#
export CVS_RSH=ssh
export CVSROOT=~/CVSROOT


#
# Subversion
#
# Subversionでチェックイン時に起動するエディタを指定
export SVN_EDITOR=vim


#
# Git
#
# Gitでコミット時に起動するエディタを指定
# 未指定だとコミット時にエラーになる(絶対パス必須)
export GIT_EDITOR=/usr/bin/vim


#
# DropBox
#
export DROPBOX=~/Dropbox
