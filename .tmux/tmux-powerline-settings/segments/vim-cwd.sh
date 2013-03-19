# Print the vim current working directory (trimmed to max length).
# NOTE The trimming code's stolen from the web. Courtesy to who ever wrote it.

# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_VIM_CWD_MAX_LEN_DEFAULT='20'

generate_segmentrc() {
   read -d '' rccontents  << EORC
# Maximum length of output.
export TMUX_POWERLINE_VIM_CWD_MAX_LEN="${TMUX_POWERLINE_VIM_CWD_MAX_LEN_DEFAULT}"
EORC
   echo "$rccontents"
}

__process_settings() {
   if [ -z "$TMUX_POWERLINE_VIM_CWD_MAX_LEN" ]; then
      export TMUX_POWERLINE_VIM_CWD_MAX_LEN="${TMUX_POWERLINE_VIM_CWD_MAX_LEN_DEFAULT}"
   fi
}

run_segment() {
    __process_settings
    vim_buf_dir=$(get_tmux_cwd)

    local vim_cwd=$(tmux showenv $(tmux display -p 'TMUX_VIM_CWD_#D' | tr -d '%') 2> /dev/null)
    vim_cwd=${vim_cwd#*=}

    if [ "$vim_buf_dir" = "$vim_cwd" ]; then
        return
    fi

    # Change $HOME to ~
    vim_cwd=${vim_cwd/#$HOME/\~}

    # Truncate from the left.
    local dir=${vim_cwd##*/}

    local max_len=$TMUX_POWERLINE_VIM_CWD_MAX_LEN
    max_len=$(( ( max_len < ${#dir} ) ? ${#dir} : max_len ))

    local offset=$(( ${#vim_cwd} - max_len ))
    if [ "$offset" -gt 0 ]; then
        vim_cwd=${vim_cwd:$offset:$max_len}
        vim_cwd=···/${vim_cwd#*/}
    fi
    echo "$vim_cwd"
}
