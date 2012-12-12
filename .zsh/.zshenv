#******************************************************************************
#
#  .zshenv
#
#  initial setup file for both interactive and noninteractive zsh
#
#  Read config sequence (except /etc/*)
#
#   login shell
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zprofile
#     $ZDOTDIR/.zshrc
#     $ZDOTDIRA/.zlogin
#
#   interactive zsh
#     $ZDOTDIR/.zshenv
#     $ZDOTDIR/.zshrc
#
#   shell scripts
#     $ZDOTDIR/.zshenv
#
#   remoteley noninteractive zsh (e.x ssh hostname command)
#     $ZDOTDIR/.zshenv
#
#   logout:
#     $ZDOTDIR/.zlogout
#     /etc/zlogout
#
#******************************************************************************

### Setup ZDOTDIR
#
# The directory to search for shell startup files (.zshrc, etc).
# If ZDOTDIR is unset, HOME is used instead.
#
ZDOTDIR=$HOME/.zsh


### Maximum size of a core dump
# Limit coredump
limit coredumpsize 0


### Setup command search path (only system basic path)
#
# System default setting path:
#
# Mac OX X (Refer to "/etc/paths", "/etc/paths.d/*")
#  /usr/bin
#  /bin
#  /usr/sbin
#  /sbin
#  /usr/local/bin
#  /usr/X11/bin
#

# Keep only the first occurrence of each duplicated value
typeset -U path

# Setup basic path
# path=($path /usr/*/bin(N-/) /usr/local/*/bin(N-/) /var/*/bin(N-/))

# Prioritize "/usr/local/*"
# path=(/usr/local/bin(N-/) /usr/local/sbin((N-/) /usr/local/share(N-/) $path)


### Setup environmental path for commands ran remotely
#

#
# rsync
#
#export RSYNC_PASSWORD=xxxx
export RSYNC_RSH=ssh

#
# CVS
#
export CVS_RSH=ssh
export CVSROOT=~/CVSROOT

