#
# grunt
#

type grunt >/dev/null 2>&1 || { echo '...skip'; return; }

if type _grunt > /dev/null 2>&1; then
    zstyle ':completion::complete:grunt::options:' show_grunt_path yes
    zstyle ':completion::complete:grunt::options:' expire 1
else
    eval "$(grunt --completion=bash)"
fi

