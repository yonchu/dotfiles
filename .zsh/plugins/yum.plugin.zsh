#
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/yum/yum.plugin.zsh
#

[ $(uname -s) = 'Linux' ] || { echo '...skip'; return; }
type yum >/dev/null 2>&1 || { echo '...skip'; return; }

## Aliases
alias ys="yum search"                       # search package
alias yp="yum info"                         # show package info
alias yl="yum list"                         # list packages
alias ygl="yum grouplist"                   # list package groups
alias yli="yum list installed"              # print all installed packages
alias ymc="yum makecache"                   # rebuilds the yum package list

alias yu="sudo yum update"                  # upgrate packages
alias yi="sudo yum install"                 # install package
alias ygi="sudo yum groupinstall"           # install package group
alias yr="sudo yum remove"                  # remove package
alias ygr="sudo yum groupremove"            # remove pagage group
alias yrl="sudo yum remove --remove-leaves" # remove package and leaves
alias yc="sudo yum clean all"               # clean cache

