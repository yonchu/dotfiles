#
# node
#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/node/node.plugin.zsh
#

type node >/dev/null 2>&1 || { echo '...skip'; return; }

# Open the node api for your current version to the optional section.
# TODO: Make the section part easier to use.
function node-docs {
	open "http://nodejs.org/docs/$(node --version)/api/all.html#all_$1"
}

# nodebrew automatically running.
if type nodebrew > /dev/null 2>&1; then
    echo
    echo 'nodebrew automatically running...'
    echo "$(nodebrew -v | head -n 1)"
    if [ -n "$DEFAULT_NODE_VERSION" ]; then
        nodebrew use "$DEFAULT_NODE_VERSION" \
            && export NODE_PATH=$HOME/.nodebrew/current/lib/node_modules
    fi
    echo
fi

if type npm > /dev/null 2>&1; then
    eval "$(npm completion 2>/dev/null)"
fi

