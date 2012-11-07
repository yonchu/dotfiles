#*******************************************************************************
#
#  .zprofile
#
#  (in $ZDOTDIR : default $HOME)
#
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read befere .zshrc when you login.
#  Not read in for subsequent shells.
#  For setting up terminal and global environment characteristics.
#
#*******************************************************************************

### Setup only grobal but interactive-use only variables ###
#

## Setup profile profile (chracteristc settings on each OS)
case "${OSTYPE}" in
    # Mac OS X
    darwin*)
    if [ -f ~/dotfiles/.profile.osx ]; then
        source ~/dotfiles/.profile.osx
    fi
    ;;
    # Linux
    linux*)
    if [ -f ~/dotfiles/.profile.linux ]; then
        source ~/dotfiles/.profile.linux
    fi
    ;;
esac

## Setup profile (common settings)
if [ -f ~/dotfiles/.profile ]; then
    source ~/dotfiles/.profile
fi


### Complete Messages
echo "Loading .zprofile completed!! (SHELL=${SHELL})"
