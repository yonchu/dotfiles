#!/usr/bin/env bash
#
# Print the status-right for tmux.
#

# .tmux directory.
dot_tmux=~/.tmux

# The powerline root directory.
cwd="${dot_tmux}/tmux-powerline"

# Source global configurations.
source "${cwd}/config.sh"

# PLATFORM {linux,bsd,mac}
case "${OSTYPE}" in
    darwin*)
        export PLATFORM="mac"
        ;;
    freebsd*)
        export PLATFORM="bsd"
        ;;
    linux*)
        export PLATFORM="linux"
        ;;
esac

# Source lib functions.
source "${cwd}/lib.sh"


## Segments
#
# Default segments path
segments_path="${cwd}/${segments_dir}"

# User segments path
user_segments_path="${dot_tmux}/segments"


## Register segments
#
declare -A lang
lang+=(["script"]="${user_segments_path}/lang.sh")
lang+=(["foreground"]="colour248")
lang+=(["background"]="colour95")
lang+=(["separator"]="${separator_left_bold}")
register_segment "lang"

declare -A uptime
uptime+=(["script"]="${user_segments_path}/uptime.sh")
uptime+=(["foreground"]="colour22")
uptime+=(["background"]="colour64")
uptime+=(["separator"]="${separator_left_bold}")
register_segment "uptime"

declare -A load_mem
load_mem+=(["script"]="${user_segments_path}/load-mem.sh")
load_mem+=(["foreground"]="colour107")
load_mem+=(["background"]="colour58")
load_mem+=(["separator"]="${separator_left_bold}")
register_segment "load_mem"

declare -A battery
if [ "$PLATFORM" == "mac" ]; then
    battery+=(["script"]="${segments_path}/battery_mac.sh")
else
    battery+=(["script"]="${segments_path}/battery.sh")
fi
battery+=(["foreground"]="colour127")
battery+=(["background"]="colour137")
battery+=(["separator"]="${separator_left_bold}")
register_segment "battery"

declare -A weather
weather+=(["script"]="${user_segments_path}/weather_yahoo.sh")
#weather+=(["script"]="${segments_path}/weather_google.sh")
weather+=(["foreground"]="colour255")
weather+=(["background"]="colour37")
weather+=(["separator"]="${separator_left_bold}")
register_segment "weather"

declare -A date
date+=(["script"]="${user_segments_path}/date.sh")
date+=(["foreground"]="colour136")
date+=(["background"]="colour235")
date+=(["separator"]="${separator_left_bold}")
register_segment "date"

# Print the status line in the order of registration above.
print_status_line_right

exit 0
