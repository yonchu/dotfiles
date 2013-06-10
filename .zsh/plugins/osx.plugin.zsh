#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/osx/osx.plugin.zsh
#

# ------------------------------------------------------------------------------
#          FILE:  osx.plugin.zsh
#   DESCRIPTION:  oh-my-zsh plugin file.
#        AUTHOR:  Sorin Ionescu (sorin.ionescu@gmail.com)
#       VERSION:  1.0.1
# ------------------------------------------------------------------------------

[ $(uname -s) = 'Darwin' ] || { echo '...skip'; return; }

function tab() {
  local command="cd \\\"$PWD\\\""
  (( $# > 0 )) && command="${command}; $*"

  the_app=$(
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        name of first item of (every process whose frontmost is true)
      end tell
EOF
  )

  [[ "$the_app" == 'Terminal' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
        tell application "Terminal" to do script "${command}" in front window
      end tell
EOF
  }

  [[ "$the_app" == 'iTerm' ]] && {
    osascript 2>/dev/null <<EOF
      tell application "iTerm"
        set current_terminal to current terminal
        tell current_terminal
          launch session "Default Session"
          set current_session to current session
          tell current_session
            write text "${command}"
          end tell
        end tell
      end tell
EOF
  }
}

function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

function cdf() {
  cd "$(pfd)"
}

function pushdf() {
  pushd "$(pfd)"
}

function ql() {
  (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

function man-preview() {
  man -t "$@" | open -f -a Preview
}
compdef man-preview=man

function trash() {
  local trash_dir="${HOME}/.Trash"
  local temp_ifs=$IFS
  IFS=$'\n'
  for item in "$@"; do
    if [[ -e "$item" ]]; then
      item_name="$(basename $item)"
      if [[ -e "${trash_dir}/${item_name}" ]]; then
        mv -f "$item" "${trash_dir}/${item_name} $(date "+%H-%M-%S")"
      else
        mv -f "$item" "${trash_dir}/"
      fi
    fi
  done
  IFS=$temp_ifs
}


## Additional

# open
alias finder='open -a finder'
alias gvim='open -a MacVim'
alias chrome='open -a Google\ Chrome'
alias edit='open -a CotEditor'

alias -g O="| xargs open"

# Open current directory in Finder.
alias f='open .'

# cd to the path of the front Finder window.
# http://blog.glidenote.com/blog/2013/02/26/jumping-to-the-finder-location-in-terminal/
function cdf() {
    local target="$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')"
    if [ -z "$target" ]; then
        echo 'Error: no Finder window found' 1>&2
        return 1
    fi
    echo "$target"
    cd "$target"
}


#
# Trash
#
alias showtrash="echo ~/.Trash ;ls -lah ~/.Trash"

function _trash(){
    for file in "$@"; do
       __trash_single_file $file
    done
}

function __trash_single_file(){
    if ! [ -d ~/.Trash/ ]; then
        command /bin/mkdir ~/.Trash
    fi

    if ! [ $# -eq 1 ]; then
        echo "__trash_single_file: 1 argument required but $# passed."
        return 1
    fi

    if [ -e $1 ]; then
        local BASENAME=$(basename $1)
        local NAME=$BASENAME
        local COUNT=0
        while [ -e ~/.Trash/$NAME ]; do
            COUNT=$(($COUNT+1))
            NAME="$BASENAME.$COUNT"
        done
        command /bin/mv $1 ~/.Trash/$NAME
    else
        echo "No such file or directory: $file"
    fi
}


# Delete .DS_Store and __MACOSX directories.
function rm-osx-cruft {
  find "${@:-$PWD}" \( \
    -type f -name '.DS_Store' -o \
    -type d -name '__MACOSX' \
  \) -delete
  # \) -print0 | xargs -0 rm -rf
}


# Opens man pages in Preview.app.
function manp {
  local page
  if (( $# > 0 )); then
    for page in "$@"; do
      man -t "$page" | open -f -a Preview
    done
  else
    print 'What manual page do you want?' >&2
  fi
}

