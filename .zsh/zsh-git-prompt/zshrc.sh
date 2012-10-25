#
#  Default values for the appearance of the prompt.
#  Configure at will.
#
#  How to install
#     source path/to/zshrc.sh
#
#     # an example prompt
#     PROMPT='%B%m%~%b$(git_super_status) %# '
#
###############################################################################

### Style settings
#
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[yellow]%}git%{${reset_color}%})-["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[blue]%}● "
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[yellow]%}✚ "
ZSH_THEME_GIT_PROMPT_REMOTE=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="… "
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[cyan]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "

###############################################################################


if [ -z "$__ZSH_GIT_PROMPT_DIR" ]; then
    __ZSH_GIT_PROMPT_DIR=$(cd $(dirname $0) && pwd)
fi
export __ZSH_GIT_PROMPT_DIR


### The function called by zsh
#
git_super_status() {
    if ! type git > /dev/null 2>&1; then
        return 0
    fi

    CMD_GITSTATUS="${__ZSH_GIT_PROMPT_DIR}/gitstatus-fast.py"

    if [ ! -f "${CMD_GITSTATUS}" ]; then
        echo '[ zsh-git-prompt - error: gitstatus-fast.py is not found ]'
        return 0
    fi

    GIT_STATUS=$(python ${CMD_GITSTATUS} 2>/dev/null)
    if [ -z "$GIT_STATUS" ];then
        return 0
    fi

    CURRENT_GIT_STATUS=("${(@f)GIT_STATUS}")
    GIT_BRANCH=$CURRENT_GIT_STATUS[1]
    GIT_REMOTE=$CURRENT_GIT_STATUS[2]
    GIT_STAGED=$CURRENT_GIT_STATUS[3]
    GIT_CONFLICTS=$CURRENT_GIT_STATUS[4]
    GIT_CHANGED=$CURRENT_GIT_STATUS[5]
    GIT_UNTRACKED=$CURRENT_GIT_STATUS[6]
    GIT_STASHED=$CURRENT_GIT_STATUS[7]
    GIT_CLEAN=$CURRENT_GIT_STATUS[8]


    local STATUS="($GIT_BRANCH"
    STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
    if [ -n "$GIT_REMOTE" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_REMOTE$GIT_REMOTE%{${reset_color}%}"
    fi
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
    if [ "$GIT_STAGED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
    fi
    if [ "$GIT_CONFLICTS" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
    fi
    if [ "$GIT_CHANGED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
    fi
    if [ "$GIT_UNTRACKED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
    fi
    if [ "$GIT_STASHED" -ne "0" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STASHED$GIT_STASHED%{${reset_color}%}"
    fi
    if [ "$GIT_CLEAN" -eq "1" ]; then
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
    STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    echo "$STATUS"
}

# vim: ft=zsh

