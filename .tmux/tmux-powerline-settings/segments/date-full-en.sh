# Print the date full (e.g. Sun 00/00/00 00:00:00)

run_segment() {
    LANG=C date +"%a %D %H:%M:%S"
    return 0
}
