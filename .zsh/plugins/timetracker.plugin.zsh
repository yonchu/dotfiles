#
# Notification of local host command
# ----------------------------------
#
# Automatic notification via growlnotify / notify-send
#
#
# Notification of remote host command
# -----------------------------------
#
# "==ZSH LONGRUN COMMAND TRACKER==" is printed after long run command execution
# You can utilize it as a trigger
#
# ## Example: iTerm2 trigger( http://qiita.com/yaotti/items/3764572ea1e1972ba928 )
#
#  * Trigger regex: ==ZSH LONGRUN COMMAND TRACKER==(.*)
#  * Parameters: \1
#

#  http://qiita.com/hayamiz/items/d64730b61b7918fbb970

if ! type growlnotify >/dev/null 2>&1 \
    && ! type notify-send >/dev/null 2>&1 \
    && [[ -z "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    echo '...skip'
    return
fi

## Settings
zstyle ':timetracker:time' threshold_sec 10
zstyle ':timetracker:message:symbol' success '◯'
zstyle ':timetracker:message:symbol' fail '×'

zstyle ':timetracker:message' format \
    'Command finished!' \
    '- Time: %t seconds' \
    '- Status: %s (%v)' \
    '- Command: %c'

zstyle ':timetracker:command' blacklist \
    'vi' 'vim' 'man' 'less' 'tail' 'tmux' 'tmuxx' 'screen' 'git'


## preexec functioin
function __my_preexec_start_timetracker() {
    local cmd
    local -a cmd blacklist
    zstyle -a ':timetracker:command' blacklist blacklist
    cmd="${${(s: :)1}[1]}"
    [[ -n "${blacklist[(r)$cmd]}" ]] && return
    zstyle ':timetracker:command' name "$1"
    zstyle ':timetracker:time' start $(date +%s)
}

## precmd functioin
function __my_precmd_end_timetracker() {
    local status_val=$? threshold_sec start_time exec_time

    zstyle -s ':timetracker:time' threshold_sec threshold_sec
    zstyle -s ':timetracker:time' start start_time

    [[ -z $start_time || -z $threshold_sec ]] && return

    exec_time=$(( $(date +%s) - $start_time ))
    if (( $exec_time >= $threshold_sec )); then
        local command_name success_symbol fail_symbol status_symbol message
        local -a  msg_format

        zstyle -s ':timetracker:command' name command_name
        zstyle -s ':timetracker:message:symbol' success success_symbol || success_symbol='success'
        zstyle -s ':timetracker:message:symbol' fail fail_symbol || fail_symbol='fail'
        zstyle -a ':timetracker:message' format msg_format

        msg_format="${(j:\n:)msg_format}"

        if [[ $status_val -eq 0 ]]; then
            status_symbol=$success_symbol
        else
            status_symbol=$fail_symbol
        fi

        zformat -f message "$msg_format" \
            "t:$exec_time" "s:$status_symbol" "v:$status_val" "c:$command_name"

        if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
            # show trigger string
            echo -e "\e[0;30m==ZSH LONGRUN COMMAND TRACKER==$(hostname -s): $command_name ($status_val)($exec_time seconds)\e[m"
            sleep 1
            # wait 1 sec, and then delete trigger string
            echo -e "\e[1A\e[2K"
        elif type growlnotify >/dev/null 2>&1; then
            echo "$message" | growlnotify -n 'ZSH timetracker' --appIcon Terminal
        elif type notify-send >/dev/null 2>&1; then
            notify-send 'ZSH timetracker' "$message"
        fi
    fi

    zstyle -d ':timetracker:command' name
    zstyle -d ':timetracker:time' start
}

add-zsh-hook preexec __my_preexec_start_timetracker
add-zsh-hook precmd __my_precmd_end_timetracker
