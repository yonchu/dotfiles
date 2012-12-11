setopt transient_rprompt

## For zsh-vcs-prompt (vcs_super_info)
if [ -f ~/.zsh/zsh-vcs-prompt/zshrc.sh ]; then
    source ~/.zsh/zsh-vcs-prompt/zshrc.sh
fi

## Left prompt (1st line)
# User@Host
PROMPT='%{%F{white}%K{blue}%} %n%{%k%f%}'
PROMPT+='%{%F{white}%K{blue}%}@%{%k%f%}'
PROMPT+='%{%F{white}%K{blue}%}%m %{%k%f%}'
PROMPT+='%{%F{blue}%K{cyan}%}⮀%{%k%f%}'
# Curent directory
PROMPT+='%{%F{white}%K{cyan}%} [%~] %{%k%f%}'
PROMPT+='%{%F{cyan}%K{red}%}⮀%{%k%f%}'
# Command status
PROMPT+='%(?.%{%F{white}%K{red}%} ◯ :%? %{%k%f%}.%{%B%F{white}%K{red}%} × :%? %{%b%k%f%})'
PROMPT+='%{%F{red}%K{green}%}⮀%{%k%f%}'
# History counts
PROMPT+='%{%F{white}%K{green}%} %h %{%k%f%}'
#PROMPT+='%{%F{green}%K{magenta}%}⮀%{%k%f%}'
# Git
PROMPT+='%K{black}%} $(vcs_super_info) %{%k%}'
PROMPT+='%{%F{black}%K{magenta}%}⮀%{%k%f%}'
# Date-time
PROMPT+='%{%B%F{black}%K{magenta}%} %D{%Y-%m-%d %H:%M:%S} %{%b%k%f%}'
PROMPT+='%{%F{magenta}%}⮀%{%k%f%}'

## Left promt (2nd line)
# Begin a new line
PROMPT+=$'\n'
# SSH
PROMPT+='$(_client_ip)'
# tmux/screen
PROMPT+='%{%F{magenta}%K{black}%}${WINDOW:+" #$WINDOW"}$([ -n "$TMUX" ] && tmux display -p " #I-#P")%{%k%f%}'
# Shell
PROMPT+='%{%F{white}%K{black}%} $0 %{%k%f%}'
PROMPT+='%{%K{white}%F{black}%}⮀%{%k%f%}'
# The symbol that identifies user type (root or normal) and job counts
PROMPT+='%{%B%F{black}%K{white}%} %(1j,(%j),)%# %{%b%k%f%f%}'
PROMPT+='%{%F{white}%K{black}%}⮀%{%k%f%} >> '


## Right prompt
# tty
RPROMPT='%{%F{blue}%}⮂%{%f%}'
RPROMPT+='%{%F{white}%K{blue}%} %l %{%f%k%}'
# LANG
RPROMPT+='%{%F{cyan}%K{blue}%}⮂%{%k%f%}'
RPROMPT+='%{%F{white}%K{cyan}%} $LANG %{%k%f%}'
# OS type
RPROMPT+='%{%F{green}%K{cyan}%}⮂%{%k%f%}'
RPROMPT+='%{%F{white}%K{green}%} $(_ostype) %{%k%f%}'
# Python
RPROMPT+='%{%F{red}%K{cyan}%}⮂%{%k%f%}'
RPROMPT+='%{%F{white}%K{red}%} $(_python_type) %{%k%f%}'

# OS type
function _ostype() {
    echo "$(uname -s)$(uname -r)"
}

# SSH
#  http://d.hatena.ne.jp/kakurasan/20070611/p1
function _client_ip() {
    if [ -n "${SSH_CONNECTION}" ]; then
        # Client IP - Client Port - Server IP - Server Port
        local ip=$(echo "${SSH_CONNECTION}" | cut -d ' ' -f 1)
        echo "%{%B%F{black}%K{yellow}%}SSH($ip)%{%k%f%b%}%{%F{yellow}%K{black}%}⮀%{%k%f%}"
    fi
}

# Python
function _python_type() {
    local python_path=$(which python 2> /dev/null)
    local pytype
    if [ -z "$python_path" ]; then
        pytype='none'
    elif [ "$python_path" = '/usr/bin/python' ]; then
        pytype='def'
    elif [ "$python_path" = '/usr/local/bin/python' ]; then
        pytype='local'
    elif echo "$python_path" | fgrep -q '/.pythonbrew/'; then
        if [ -n "$VIRTUAL_ENV" ]; then
            pytype=$(basename "$VIRTUAL_ENV")
        else
            pytype='*py'$(echo "$python_path" | sed 's%.*Python-\([^/]*\)/.*%\1%' | tr -d '.')
        fi
    else
        if [ -n "$VIRTUAL_ENV" ]; then
            pytype=$(basename "$VIRTUAL_ENV")
        else
            pytype=$python_path
        fi
    fi
    echo "$pytype"
}

## Git.
# No action.
ZSH_VCS_PROMPT_GIT_FORMATS='%{%K{black}%}(%{%B%F{green}%}#s%{%f%b%}%{%K{black}%})'
# Branch name
ZSH_VCS_PROMPT_GIT_FORMATS+='[%{%B%F{red}%K{black}%}#b%{%f%b%}'
# Ahead and Behind
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%K{black}%}#c#d|'
# Staged
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{blue}%K{black}%}#e%{%f%b%}'
# Conflicts
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{red}%K{black}%}#f%{%f%b%}'
# Unstaged
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{yellow}%K{black}%}#g%{%f%b%}'
# Untracked
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%K{black}%}#h'
# Stashed
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{cyan}%K{black}%}#i%{%f%b%}'
# Clean
ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{green}%K{black}%}#j%{%f%b%}%{%K{black}%}]'

# No action using python.
# VCS name
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON='%{%K{black}%}(%{%B%F{yellow}%K{black}%}#s%{%f%b%}%{%K{black}%})'
# Branch name
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='[%{%B%F{red}%K{black}%}#b%{%f%b%}'
# Ahead and Behind
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%K{black}%}#c#d|'
# Staged
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%F{blue}%K{black}%}#e%{%f%b%}'
# Conflicts
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%F{red}%K{black}%}#f%{%f%b%}'
# Unstaged
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%F{yellow}%K{black}%}#g%{%f%b%}'
# Untracked
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%K{black}%}#h'
# Stashed
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%F{cyan}%K{black}%}#i%{%f%b%}'
# Clean
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON+='%{%F{green}%K{black}%}#j%{%f%b%}%{%K{black}%}]'

# Action.
# VCS name
#
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS='%{%K{black}%}(%{%B%F{yellow}%K{black}%}#s%{%f%b%}%{%K{black}%})'
# Branch name
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='[%{%B%F{red}%K{black}%}#b%{%f%b%}'
# Action
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%K{black}%}:%{%B%F{red}%K{black}%}#a%{%f%b%}'
# Ahead and Behind
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%K{black}%}#c#d|'
# Staged
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{blue}%K{black}%}#e%{%f%b%}'
# Conflicts
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{red}%K{black}%}#f%{%f%b%}'
# Unstaged
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{yellow}%K{black}%}#g%{%f%b%}'
# Untracked
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%K{black}%}#h'
# Stashed
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{cyan}%K{black}%}#i%{%f%b%}'
# Clean
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{green}%K{black}%}#j%{%f%b%}%{%K{black}%}]'


## Other vcs.
# No action.
# VCS name
ZSH_VCS_PROMPT_VCS_FORMATS='%{%K{black}%}(%{%B%F{green}%K{black}%}#s%{%f%b%}%{%K{black}%})'
# Branch name
ZSH_VCS_PROMPT_VCS_FORMATS+='[%{%B%F{red}%K{black}%}#b%{%f%b%}%{%K{black}%}]'

# Action.
# VCS name
ZSH_VCS_PROMPT_VCS_ACTION_FORMATS='%{%K{black}%}(%{%B%F{green}%K{black}%}#s%{%f%b%}%{%K{black}%})'
# Branch name
ZSH_VCS_PROMPT_VCS_ACTION_FORMATS+='[%{%B%F{red}%K{black}%}#b%{%f%b%}'
# Action
ZSH_VCS_PROMPT_VCS_ACTION_FORMATS+=':%{%B%F{red}%K{black}%}#a%{%f%b%}%{%K{black}%}]'

# vim: ft=zsh

