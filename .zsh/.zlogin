#******************************************************************************
#
#  .zlogin
#
#  (in $ZDOTDIR : default $HOME)
#
#  Initial setup file for only interactive zsh.
#  Read in after the .zshrc file when you log in.
#  Not read in for subsequent shells.
#
#******************************************************************************

# Execute code that does not affect the current session in the background.
{
    # Compile the completion dump to increase startup speed.
    # zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    zcompdump="$HOME/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        echo "Run zcompile $zcompdump in the background ..."
        zcompile "$zcompdump"
    fi
} &!

# ssh-agent etc..

# Setup man search path.
#   System default setting path:
#   Mac OX X (Refer to "/etc/manpaths", "/etc/manpaths.d/*")
#     /usr/share/man
#     /usr/local/share/man
#     /usr/X11/share/man
# Keep only the first occurrence of each duplicated value.
typeset -U manpath
# Setup manpath
manpath=(/usr/*/man(N-/) /usr/local/*/man(N-/) /var/*man(N-/))
# Prioritize "/usr/local/*", "/opt/local/*"
manpath=(/usr/local/share/man /opt/local/share/man /usr/local/jman $manpath)
# Export MANPATH
export MANPATH

# Complete Messages.
echo "Loading .zlogin completed!!"

# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] )); then
    echo
    echo '===== fortune ====='
    fortune -a
fi
if (( $+commands[w] )); then
    echo '===== Login Status ====='
    w
fi
echo

# Restore session.
if [[ -f ~/.zsh_session && \
    ( -z $TMUX || $(tmux display -p "#D") == '%0' ) ]]; then
    source ~/.zsh_session
fi

