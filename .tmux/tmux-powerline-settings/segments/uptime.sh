# Prints the uptime.

run_segment() {
    local uptime=$(uptime | grep -PZo "(?<=up )[^,]*" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//')
    echo "☝ $uptime"
    return 0
}
