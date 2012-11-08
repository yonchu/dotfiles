#*******************************************************************************
#
# .bash_profile
#   ログイン時に一度だけ読み込まれる
#
#*******************************************************************************

#
# profile設定(共通)
#
if [ -f ~/dotfiles/.profile ]; then
    source ~/dotfiles/.profile
fi

#
# profile設定(OS固有)
#
case "${OSTYPE}" in
    # Mac(Unix)
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

#
# .bashrc 読み込み
#
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


## complete message
echo ".bash_profile load completed...($SHELL)"
