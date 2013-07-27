#
# promptway
#
#  https://github.com/pasberth/promptway
#

[ -f ~/.zsh/plugins/promptway/promptway.zsh ] || { echo '...skip'; return; }

if ! (type realpath || type grealpath) > /dev/null 2>&1; then
    echo '...skip (command not found: realpath or grealpath)'
    return
fi

## Source promptway.zsh
# zstyle による設定前に読み込むこと
source ~/.zsh/plugins/promptway/promptway.zsh

### promptway のカスタマイズ

## カレントディレクトリの設定
# カレントディレクトリのフォーマット
zstyle ':prompt:dir' formats '%F{red}%a%f'

## 前ディレクトリの設定
# zstyle ':prompt:backward' enable ''
# 前ディレクトリのフォーマット
zstyle ':prompt:backward:dir' formats '%U%a%u'

## パス省略の設定
# パス省略を有効 (default: 無効)
zstyle ':prompt:truncate' enable yes
# 省略記号 (default: ...)
zstyle ':prompt:truncate' symbol '… '
# パス最大長 (default: 30)
#zstyle ':prompt:truncate' max_length 40
# カレントディレクトリの親ディレクトリを表示する (default: 無効)
zstyle ':prompt:truncate' show_working_parent yes
# 1つ前のディレクトリの親ディレクトリを表示する (default: 無効)
#zstyle ':prompt:truncate' show_backward_parent yes
# "/" 直下のディレクトリを表示する (default: 無効)
zstyle ':prompt:truncate' show_slash_second_root yes
# "~/" 直下のディレクトリを表示する (default: 無効)
zstyle ':prompt:truncate' show_home_second_root yes
# 名前付きディレクトリ直下のディレクトリを表示する (default: 無効)
# zstyle ':prompt:truncate' show_named_dir_second_root yes

## Permission 表示 (不要ならformatsをコメントアウト)
# カレントディレクトリの Permission
zstyle ':prompt:permission:dir' formats '(%F{yellow}%a%b%f)'
zstyle ':prompt:permission:dir' non_owner_symbol '⭤'
# 前ディレクトリの Permission
zstyle ':prompt:permission:backward' formats '(%F{blue}%a%b%f)'
zstyle ':prompt:permission:backward' non_owner_symbol '⭤'


_promptway_backward () {
    _prompt_backward=
}
