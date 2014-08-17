# Prints the uptime.

run_segment() {
    local uptime=$(uptime | grep -oiE 'up.*user[^,]*' | sed -e 's/^up //' -e 's/,[^,]*user//' -e 's/^[ \t]*//' -e 's/[ \t]*$//')
    echo "☝ $uptime"
    return 0
}
