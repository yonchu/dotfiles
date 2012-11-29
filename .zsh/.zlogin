#******************************************************************************
#
#  .zlogin
#
#  (in $ZDOTDIR : default $HOME)
#
#  initial setup file for only interactive zsh
#  Read in after the .zshrc file when you log in.
#  Not read in for subsequent shells.
#
#******************************************************************************

### ssh-agent etc..


### Setup man search path
#
# System default setting path:
#
# Mac OX X (Refer to "/etc/manpaths", "/etc/manpaths.d/*")
#  /usr/share/man
#  /usr/local/share/man
#  /usr/X11/share/man
#

# Keep only the first occurrence of each duplicated value
typeset -U manpath

# Setup manpath
manpath=(/usr/*/man(N-/) /usr/local/*/man(N-/) /var/*man(N-/))

# Prioritize "/usr/local/*", "/opt/local/*"
manpath=(/usr/local/share/man /opt/local/share/man /usr/local/jman $manpath)

# Export MANPATH
export MANPATH


### Complete Messages
echo "Loading .zlogin completed!!"

