#
# grunt
#

type grunt >/dev/null 2>&1 || { echo '...skip'; return; }

if ! type _grunt > /dev/null 2>&1; then
    eval "$(grunt --completion=bash)"
fi
