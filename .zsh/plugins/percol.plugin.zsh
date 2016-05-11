#
# percol
#
#  https://github.com/mooz/percol
#  https://gist.github.com/mitukiii/4234173
#  http://d.hatena.ne.jp/kbkbkbkb1/20120429/1335835500
#  http://www.kaichan.mydns.jp/~kai/wordpress/?p=502
#
#  Usage:
#    $ percol /var/log/syslog
#    $ ps aux | percol

type percol > /dev/null 2>&1 || { echo '...skip'; return; }
type peco   > /dev/null 2>&1 && { echo '...skip'; return; }

alias -g P='| percol --match-method migemo'

alias ps-percol='ps aux | percol | awk "{ print \$2 }"'
alias kill-percol='ps aux | percol | awk "{ print \$2 }" | xargs kill'

## Grep process.
function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

## Kill process.
function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}

## History search.
function percol_select_history() {
    local tac
    if type gtac > /dev/null 2>&1; then
        tac="gtac"
    elif type tac > /dev/null 2>&1; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | \
        eval $tac | \
        percol --match-method migemo --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
    # zle clear-screen
}
zle -N percol_select_history
bindkey '^r' percol_select_history

## Search documens.
function percol-search-document() {
    if [ $# -ge 1 ]; then
        DOCUMENT_DIR=$*
    else
        DOCUMENT_DIR=($HOME/Dropbox)
        if [ -d $HOME/Documents ]; then
            DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
        fi
    fi
    SELECTED_FILE=$(echo $DOCUMENT_DIR | \
        xargs find | \
        grep -E "\.(txt|md|pdf|key|numbers|pages|doc|xls|ppt)$" | \
        percol --match-method migemo)
    if [ $? -eq 0 ]; then
        echo $SELECTED_FILE | sed 's/ /\\ /g'
    fi
}
alias pdoc='percol-search-document'

## Search wich locate.
function percol-search-locate() {
    if [ $# -ge 1 ]; then
        SELECTED_FILE=$(locate $* | percol --match-method migemo)
        if [ $? -eq 0 ]; then
            echo $SELECTED_FILE | sed 's/ /\\ /g'
        fi
    else
        builtin locate
    fi
}
alias plocate='percol-search-locate'

## Git log.
# http://tomykaira.hatenablog.com/entry/2013/05/12/115152
function pgitlog {
    line=`\git log --pretty=format:'%h <%an> -%d %s' --abbrev-commit --graph --no-color | percol`
    rev=`echo "$line" | awk 'match($0,/[a-f0-9]+/) {print substr($0,RSTART,RLENGTH)}'`
    git $* $rev
}

## Git reflog
function pgitref {
    line=`\git reflog | percol`
    rev=`echo "$line" | awk '{ print $1 }'`
    git $* $rev
}
