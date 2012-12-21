#
# zaw
#
#  https://github.com/zsh-users/zaw
#  https://github.com/nakamuray/zaw
#
#  zsh anything.el-like widget
#
#  Execute action by pressing enter key or
#  press Meta-enter for alternative action.
#  instead, press tab key and select action you want to execute.
#
#  Enter  : enter
#  Select : ^n,^p
#  Back   : ^c
#  End    : ^c*2
#  Multi select : ^@ (control + space)
#
#  Print source:
#   $ zaw-print-src
#   source name      shortcut widget name
#   ----------------------------------------
#   ack              zaw-ack
#   applications     zaw-applications
#   bookmark         zaw-bookmark
#   cdd              zaw-cdd
#   cdr              zaw-cdr
#   dirstack         zaw-dirstack
#   git-branches     zaw-git-branches
#   git-files        zaw-git-files
#   history          zaw-history
#   open-file        zaw-open-file
#   perldoc          zaw-perldoc
#   screens          zaw-screens
#   tmux             zaw-tmux

[ -f ~/.zsh/zaw/zaw.zsh ] || { echo '...skip'; return; }

source ~/.zsh/zaw/zaw.zsh || { echo '...skip(source error)'; return 1; }

## Basic settings
zstyle ':filter-select' case-insensitive yes

## Bindkey
bindkey -r '^Q'
bindkey '^Q^q' zaw
bindkey '^Qq' zaw

bindkey '^Qh' zaw-history
bindkey '^Qr' zaw-cdr
bindkey '^Qt' zaw-cdd
bindkey '^Qd' zaw-dirstack
bindkey '^Qgf' zaw-git-files
bindkey '^Qgd' zaw-git-dirs
bindkey '^Qgl' zaw-git-log


## zaw-src-cdd
# http://blog.kentarok.org/entry/2012/03/24/221522
if (( $+functions[cdd] )); then
    function zaw-src-cdd () {
        if [ -r "$CDD_PWD_FILE" ]; then
            for window in `cat $CDD_PWD_FILE | sed '/^$/d'`; do
                candidates+=("${window}")
            done

            actions=(zaw-src-cdd-cd)
            act_descriptions=("cdd for zaw")
        fi
    }
    function zaw-src-cdd-cd () {
        BUFFER="cd `echo $1 | cut -d ':' -f 2`"
        zle accept-line
    }
    zaw-register-src -n cdd zaw-src-cdd
fi

## zaw-src-dirstack
# http://d.hatena.ne.jp/hchbaw/20110224/zawzsh
zmodload zsh/parameter
function zaw-src-dirstack() {
    : ${(A)candidates::=$dirstack}
    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}
zaw-register-src -n dirstack zaw-src-dirstack


## zaw-src-git-dirs
# http://d.hatena.ne.jp/syohex/20121219/1355925874
function zaw-src-git-dirs () {
    local _dir=$(git rev-parse --show-cdup 2>/dev/null)
    if [ $? -eq 0 ]
    then
        candidates=( $(git ls-files ${_dir} | perl -MFile::Basename -nle \
                       '$a{dirname $_}++; END{delete $a{"."}; print for sort keys %a}') )
    fi

    actions=("zaw-src-git-dirs-cd")
    act_descriptions=("change directory in git repos")
}
function zaw-src-git-dirs-cd () {
    BUFFER="cd $1"
    zle accept-line
}
zaw-register-src -n git-dirs zaw-src-git-dirs


## zaw-src-git-log
# https://gist.github.com/4350604
# If true, print full SHA.
ZAW_SRC_GIT_LOG_NO_ABBREV=${ZAW_SRC_GIT_LOG_NO_ABBREV:-'false'}

# Limit the number of commits to output.
# If set the value less than 1, output unlimitedly.
ZAW_SRC_GIT_LOG_MAX_COUNT=${ZAW_SRC_GIT_LOG_MAX_COUNT:-100}

# Date style (relative, local, iso, rfc, short, raw, default)
ZAW_SRC_GIT_LOG_DATE_STYLE=${ZAW_SRC_GIT_LOG_DATE_STYLE:-'short'}

# The function to regiter to zaw.
function zaw-src-git-log () {
    # Check git directory.
    git rev-parse -q --is-inside-work-tree > /dev/null 2>&1 || return 1

    # Set up additional option.
    local opt
    if [ "$ZAW_SRC_GIT_LOG_NO_ABBREV" != 'false' ]; then
        opt=' --no-abbrev'
    fi
    if [ $ZAW_SRC_GIT_LOG_MAX_COUNT -gt 0 ]; then
        opt+=" --max-count=$ZAW_SRC_GIT_LOG_MAX_COUNT"
    fi
    if [ -n "$ZAW_SRC_GIT_LOG_DATE_STYLE" ]; then
        opt+=" --date=$ZAW_SRC_GIT_LOG_DATE_STYLE"
    fi

    # Get git log.
    local log="$(git log --pretty=format:'%h %ad | %s %d [%an]' $opt)"

    # Set candidates.
    candidates+=(${(f)log})
    actions=("zaw-src-git-log-append-to-buffer")
    act_descriptions=("git-log for zaw")
    # Enale multi marker.
    options+=(-m)
}
# Action function.
function zaw-src-git-log-append-to-buffer () {
    local list
    local item
    for item in "$@"; do
        list+="$(echo "$item" | cut -d ' ' -f 1) "
    done
    set -- $list

    local buf=
    if [ $# -eq 2 ]; then
        # To diff.
        buf+="$1..$2"
    else
        # 1 or 3 or more items.
        buf+="${(j: :)@}"
    fi
    # Append left buffer.
    LBUFFER+="$buf"
}
# Register this src to zaw.
zaw-register-src -n git-log zaw-src-git-log

