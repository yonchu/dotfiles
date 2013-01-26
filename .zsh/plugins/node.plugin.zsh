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
