# Yonchu Theme

if patched_font_in_use; then
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="⮂"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="⮃"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="⮀"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="⮁"
else
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}


# Format: segment_name background_color foreground_color [non_default_separator]

window_width=$($TMUX_POWERLINE_DIR_USER_SEGMENTS/../window-width.sh)
# window_title=$(tmux display -p '#W')

is_minimum=$(tmux showenv TMUX_MINIMUM_STATUS 2> /dev/null)

if [ -n "$is_minimum" ]; then
    if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=()
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("tmux_session_info 148 234")
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("hostname 63 255")
    fi
    if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=()
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("lang 95 248")
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("date-full-en 235 136")
    fi
else
    if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=()
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("tmux_session_info 148 234")
        if [ "$window_width" -ge 170 ]; then
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("hostname 63 255")
        fi
        if [ "$window_width" -ge 200 ]; then
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("whoami 69 238")
        fi
        if [ "$window_width" -ge 140 ]; then
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("ostype 33 21")
        fi
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("lan_ip 24 255 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}")
        TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("wan_ip 24 255")
        if [ "$window_width" -ge 190 ]; then
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("vcs_branch 29 88")
        fi
        if [ "$window_width" -ge 250 ]; then
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("vcs_compare 60 255")
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("vcs_staged 64 255")
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("vcs_modified 9 255")
            TMUX_POWERLINE_LEFT_STATUS_SEGMENTS+=("vcs_others 245 0")
        fi
    fi

    if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=()
        if [ "$window_width" -ge 122 ]; then
            TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("lang 95 248")
        fi
        if [ "$window_width" -ge 160 ]; then
            TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("uptime 64 22")
        fi
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("load 58 107")
        if [ "$window_width" -ge 168 ]; then
            TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("used-mem-full 58 107 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}")
        else
            TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("used-mem 58 107 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}")
        fi
        TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS+=("date-full-en 235 136")
    fi
fi
