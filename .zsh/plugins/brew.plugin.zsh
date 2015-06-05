#
# homebrew
#
if [ "$(uname -s)" != 'Darwin' ] || ! type brew >/dev/null 2>&1; then
    echo '...skip'
    return
fi

alias b='brew'
alias bl='brew list'
alias bup='brew update'
alias bs='brew search'
alias bgit='brew info --github'
alias bls='brew list --versions'
alias bed='brew edit'
alias bins='brew install -v'
# alias buins='brew uninstall'
# alias bupg='brew upgrade -v'
# alias bcl='brew cleanup'
alias bdep='brew uses --installed'
alias cdbr='pushd $(brew --prefix)/'

alias brews='brew list -1'

# Check git completion.
if [ -f /usr/local/share/zsh/site-functions/_git ]; then
    echo '---------------------------'
    echo 'WARNNING: git/_git is used.'
    echo '---------------------------'
fi

# Check /usr/local permission
_owner=($(command ls -l /usr | awk '/local$/ {print $3,$4}'))
if [[ ${_owner[1]} != 'root' || ${_owner[2]} != 'admin' ]]; then
    echo '---------------------------'
    echo "WARNNING: Unexpected permission: /usr/local (${_owner[1]}:${_owner[2]})"
    echo '---------------------------'
fi
unset _owner
