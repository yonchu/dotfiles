#
# homebrew
#
type brew >/dev/null 2>&1 || { echo '...skip'; return; }

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

