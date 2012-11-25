#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/python/python.plugin.zsh
#

# Find python file
alias pyfind='find . -name "*.py"'

# Remove python compiled byte-code
alias pyclean='find . -type f -name "*.py[co]" -delete'

# Grep among .py files
alias pygrep='grep --include="*.py"'

function py273() {
    if type pybrew > /dev/null 2>&1; then
        pybrew switch 2.7.3 && pybrew venv use py273
    fi
}

function py323() {
    if type pybrew > /dev/null 2>&1; then
        pybrew switch 3.2.3 && pybrew venv use py323
    fi
}

function cdsite() {
    local py_cmd
    py_cmd=`cat << 'EOF'
from __future__ import print_function
import sys
import os
import site

site_prefix = site.PREFIXES[0]
version = str(sys.version_info[0]) + '.' + str(sys.version_info[1])
site_path = os.path.join(site_prefix, 'lib/python' + version, 'site-packages')
print(site_path)
EOF`

    local site_path=$(python -c "$py_cmd")
    [ -d "$site_path" ] || return 1
    echo "$site_path"
    cd "$site_path"
}

