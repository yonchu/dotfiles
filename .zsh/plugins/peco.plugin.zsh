# peco
#
#  https://github.com/peco/peco
#
#  Usage:
#    $ peco [options] [FILE]
#    $ ps aux | peco
#    $ peco -h
#
#  Config:
#    ~/.config/peco/config.json
#
#  Default Keymap:
#    Esc        peco.Cancel
#    C-c        peco.Cancel
#    Enter      peco.Finish
#    C-f        peco.ForwardChar
#    C-a        peco.BeginningOfLine
#    C-b        peco.BackwardChar
#    C-d        peco.DeleteForwardChar
#    C-e        peco.EndOfLine
#    C-k        peco.KillEndOfLine
#    C-u        peco.KillBeginningOfLine
#    BS         peco.DeleteBackwardChar
#    C-8        peco.DeleteBackwardChar
#    C-w        peco.DeleteBackwardWord
#    C-g        peco.SelectNone
#    C-n        peco.SelectDown
#    C-p        peco.SelectUp
#    C-r        peco.RotateMatcher
#    C-t        peco.ToggleQuery
#    C-Space    peco.ToggleSelectionAndSelectNext
#    ArrowUp    peco.SelectUp
#    ArrowDown  peco.SelectDown
#    ArrowLeft  peco.ScrollPageUp
#    ArrowRight peco.ScrollPageDown
# ----------------------------------------------------------------------------

type peco > /dev/null 2>&1 || { echo '...skip'; return; }

alias -g P='| peco --select-1'

alias ps-peco='ps aux | peco | awk "{ print \$2 }"'
alias kill-peco='ps aux | peco | awk "{ print \$2 }" | xargs kill'

# Search command history.
function peco-select-history() {
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
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
  # zle clear-screen
}
zle -N peco-select-history
bindkey '^rr' peco-select-history
bindkey '^r^r' peco-select-history

# cdr.
function peco-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle -R -c
  # zle clear-screen
}
zle -N peco-cdr
bindkey '^rb' peco-cdr
bindkey '^r^b' peco-cdr

# Grep process.
function ppgrep() {
  local peco=peco
  if [[ -n $1 ]]; then
    peco="$peco --query $1"
  fi
  ps aux | eval "$peco" | awk '{ print $2 }'
}

# Kill process.
function ppkill() {
  local query
  if [[ $1 =~ "^-" ]]; then
    query=""
  else
    query=$1
    [[ $# > 0 ]] && shift
  fi
  ppgrep $query | xargs kill $*
}

# Git add.
function peco-select-gitadd() {
  local selected_file_to_add
  selected_file_to_add="$(
  git status --porcelain \
    | peco \
    | awk -F ' ' '{print $NF}' \
    | tr "\n" " "
  )"

  if [ -n "$selected_file_to_add" ]; then
    BUFFER="git add $selected_file_to_add"
    CURSOR=$#BUFFER
    zle accept-line
  fi
  zle reset-prompt
}
zle -N peco-select-gitadd
bindkey '^rga' peco-select-gitadd

# Git log.
# http://tomykaira.hatenablog.com/entry/2013/05/12/115152
function pgitlog {
  line=`\git log --pretty=format:'%h <%an> -%d %s' --abbrev-commit --graph --no-color | peco`
  rev=`echo "$line" | awk 'match($0,/[a-f0-9]+/) {print substr($0,RSTART,RLENGTH)}'`
  git "$@" "$rev"
}

# Git reflog
function pgitref {
  line=`\git reflog | peco`
  rev=`echo "$line" | awk '{ print $1 }'`
  git "$*" "$rev"
}
