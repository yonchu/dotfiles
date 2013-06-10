#
# node
#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/node/node.plugin.zsh
#


# Return if requirements are not found.
# type node >/dev/null 2>&1 || { echo '...skip'; return; }
if (( ! $+commands[node] )); then
    echo '...skip'
    return
fi

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

# CoffeeScriptRedux
function coffee-redux() {
    if [ $# -eq 0 ]; then
        echo 'Error: specify coffeescript files.'
        return 1
    fi
    local in_file out_file
    local coffee_redux=~/work/dev/github_tracking/CoffeeScriptRedux/bin/coffee
    for in_file in "$@"; do
        if [ ! -f "$in_file" ]; then
            echo "Error: $1 is not found." 1>&2
            continue
        fi
        if [[ ! "$in_file" =~ .*\.coffee ]]; then
            #echo " ! Ignore $1." 1>&2
            continue
        fi
        out_file=${in_file%.coffee}
        "$coffee_redux" --js -i "$in_file" >| "$out_file".js \
            && echo "//@ sourceMappingURL=$out_file.js.map" >> "$out_file".js \
            && "$coffee_redux" --source-map -i "$in_file" >| "$out_file".js.map \
            && echo "$in_file -> $out_file.js $out_file.js.map"
    done
}

# LiveReloadX
# http://tech.nitoyon.com/ja/blog/2013/02/27/livereloadx/
#
# # Default:
#   $ livereloadx path/to/dir
#
#   Add the following js to your html.
#    <script>document.write('<script src="http://' + (location.host || 'localhost').split(':')[0] +
#    ':35729/livereload.js?snipver=2"></' + 'script>')</script>
#   or
#   use Chrome extensions.
#
# Static web server mode:
#   $ livereloadx -s [-p 35729] [path/to/dir]
#
# Reverse proxy mode:
#   $ livereloadx -y http://example.com/ [-p 35729] [-l] [path/to/dir]
#   $ livereloadx --proxy http://example.com/ [-p 35729] [-l] [path/to/dir]
#

# Load NPM completion.
if (( $+commands[npm] )); then
    cache_file=~/.node-completion.cache.zsh
    if [[ "$commands[npm]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
        # npm is slow; cache its output.
        npm completion >! "$cache_file" 2> /dev/null
    fi
    source "$cache_file"
    unset cache_file
fi

