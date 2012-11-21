#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/urltools/urltools.plugin.zsh
#

type python >/dev/null 2>&1 || { echo '...skip'; return; }

# URL Tools
# Adds handy command line aliases useful for dealing with URLs
#
# Taken from:
# http://ruslanspivak.com/2010/06/02/urlencode-and-urldecode-from-a-command-line/

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

