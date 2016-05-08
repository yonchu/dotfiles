#******************************************************************************
#
#  .zprofile
#
#  (in $ZDOTDIR : default $HOME)
#
#  Initial setup file for only interactive zsh.
#  This file is read after .zshenv file is read befere .zshrc when you login.
#  Not read in for subsequent shells.
#  For setting up terminal and global environment characteristics.
#
#******************************************************************************

# Terminal background color settings
# http://yskwkzhr.blogspot.jp/2012/12/set-background-color-of-vim-with-environment-variable.html
# Default dark
export COLORFGBG='15;0'
if [ -n "${(M)ITERM_PROFILE#light}" ]; then
  export COLORFGBG='0;15'
elif [ -n "${(M)COLORTERM#gnome-terminal}" ]; then
  export COLORFGBG='0;15'
fi

# Setup only global but interactive-use only variables.

# Setup common profile.
if [ -f ~/dotfiles/.profile ]; then
    source ~/dotfiles/.profile
fi

# Setup OS profile.
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

# Complete Messages.
echo "Loading .zprofile completed!! (SHELL=${SHELL})"

