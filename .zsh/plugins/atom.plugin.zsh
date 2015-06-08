#
# Atom
#

if [[ $(uname -s) != 'Darwin' || ! -a '/Applications/Atom.app' ]] ; then
    echo '...skip'
    return
fi

if ! type atom > /dev/null 2>&1; then
    function atom() {
        if [[ $# -lt 1 ]]; then
            set -- '.'
        fi
        open -a '/Applications/Atom.app' "$@"
    }
fi
