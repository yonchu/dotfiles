#
# Clipboard
#

# Alases for pbcopy
#  http://d.hatena.ne.jp/mollifier/20100317/p1
#  http://d.hatena.ne.jp/mollifier/20100317/p1
if type pbcopy >/dev/null 2>&1; then
    # Mac
    unalias pbcopy > /dev/null 2>&1
    alias -g P='| pbcopy'
elif type xsel >/dev/null 2>&1; then
    # Linux
    alias pbcopy='xsel --input --clipboard'
    alias -g P='| xsel --input --clipboard'
elif type putclip >/dev/null 2>&1; then
    # Cygwin
    alias pbcopy='putclip'
    alias -g P='| putclip'
else
    alias pbcopy='cat'
    alias -g P='| cat'
fi

# 直前のコマンドをクリップボードへ
#  第１引数：何個前のコマンドか(改行のみは除外されるはず)
function copy_prev_cmd_to_clipboard () {
    if [ -n "$1" ] && ! expr "$1" : '[0-9]*' > /dev/null ; then
        echo "error: non-numeric argument" 1>&2
        return 1
    fi
    local num=${1:-1};
    fc -ln -$num | head -n 1 | sed 's/^[ \t]*//' | tr -d '\n' | pbcopy
    #if [ -n "$BASH_VERSION" ]; then
        #history | tail -n $num | head -n 1 | sed 's/^[ \t]*//' | cut -d ' ' -f 5- | sed 's/^[ \t]*//' | pbcopy
    #else
        #num=$((num + 1))
        #tail -n $num "$HISTFILE" | perl -e '<> =~  m/;(.+)/; print $1;' | pbcopy
        ##tail -n $num "$HISTFILE" | head -n 1 | cut -d ';' -f 2- | pbcopy
    #fi
}
alias pbcc='copy_prev_cmd_to_clipboard'

