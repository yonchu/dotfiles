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
#   aliases          zaw-aliases
#   applications     zaw-applications
#   bookmark         zaw-bookmark
#   cdd              zaw-cdd
#   cdr              zaw-cdr
#   command-output   zaw-command-output
#   commands         zaw-commands
#   dirstack         zaw-dirstack
#   fasd             zaw-fasd
#   fasd-directories zaw-fasd-directories
#   fasd-files       zaw-fasd-files
#   functions        zaw-functions
#   git-branches     zaw-git-branches
#   git-directories  zaw-git-directories
#   git-files        zaw-git-files
#   git-files-legacy zaw-git-files-legacy
#   git-log          zaw-git-log
#   git-recent-all-branches zaw-git-recent-all-branches
#   git-recent-branches zaw-git-recent-branches
#   git-reflog       zaw-git-reflog
#   git-show-branch  zaw-git-show-branch
#   git-status       zaw-git-status
#   history          zaw-history
#   locate           zaw-locate
#   open-file        zaw-open-file
#   perldoc          zaw-perldoc
#   process          zaw-process
#   programs         zaw-programs
#   screens          zaw-screens
#   searcher         zaw-searcher
#   ssh-hosts        zaw-ssh-hosts
#   tmux             zaw-tmux
#   widgets          zaw-widgets

[ -f ~/.zsh/plugins/zaw/zaw.zsh ] || { echo '...skip'; return; }

source ~/.zsh/plugins/zaw/zaw.zsh || { echo '...skip(source error)'; return 1; }

## Basic settings
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' max-lines $(($LINES / 2))

## Bindkey
bindkey -r '^Q'
bindkey '^Q^q' zaw
bindkey '^Qq'  zaw

bindkey '^Qh'  zaw-history
bindkey '^Qr'  zaw-cdr
bindkey '^Qt'  zaw-cdd
bindkey '^Qd'  zaw-dirstack
bindkey '^Qz'  zaw-z
bindkey '^Qj'  zaw-z
bindkey '^Qgd' zaw-git-directories
bindkey '^Qgf' zaw-git-files
bindkey '^Qgl' zaw-git-log
bindkey '^Qgm' zaw-git-modified-files
bindkey '^Qgs' zaw-git-show-branch

## zaw-src-cdd
# http://blog.kentarok.org/entry/2012/03/24/221522
if (( $+functions[cdd] )); then
    function zaw-src-cdd () {
        if [ -r "$CDD_FILE" ]; then
            for window in `cat $CDD_FILE | sed '/^$/d'`; do
                candidates+=("${window}")
            done
            actions=(zaw-src-cdd-action)
            act_descriptions=("cdd for zaw")
        fi
    }
    function zaw-src-cdd-action () {
    LBUFFER+=$(echo "$1" | cut -d ':' -f 2)
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

## zaw-src-git-modified-files
function zaw-src-git-modified-files() {
    git rev-parse -q --is-inside-work-tree > /dev/null 2>&1 || return 1
    candidates=()
    candidates+=(${(f)"$(git diff --name-only 2>/dev/null)"})
    candidates+=(${(f)"$(git diff --name-only --staged 2>/dev/null)"})
    candidates=(${(iou)candidates[@]})
    actions=(zaw-callback-append-to-buffer)
    act_descriptions=("git-modified-files for zaw")
    options+=(-m)
}

zaw-register-src -n git-modified-files zaw-src-git-modified-files
## zaw-src-git-dirs
# http://d.hatena.ne.jp/syohex/20121219/1355925874
# https://github.com/syohex/zaw-git-directories
source "${${funcsourcetrace[1]%:*}:h}"/zaw-git-directories/git-directories.zsh

## zaw-src-git-log
# https://github.com/yonchu/zaw-src-git-log
source "${${funcsourcetrace[1]%:*}:h}"/zaw-src-git-log/zaw-git-log.zsh

## zaw-src-git-show-branch
# https://github.com/yonchu/zaw-src-git-show-branch
source "${${funcsourcetrace[1]%:*}:h}"/zaw-src-git-show-branch/zaw-git-show-branch.zsh

## zaw-z
# https://github.com/NigoroJr/zaw-z
source "${${funcsourcetrace[1]%:*}:h}"/zaw-z/zaw-z.zsh

