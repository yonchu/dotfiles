# Prints the ostype

run_segment() {
    echo "ⓞ $(uname -s)$(uname -r | cut -d '.' -f 1-2)"
    return 0
}
