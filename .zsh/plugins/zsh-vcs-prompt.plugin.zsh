#
# zsh-vcs-prompt
#
#  https://github.com/yonchu/zsh-vcs-prompt
#

[ -f ~/.zsh/plugins/zsh-vcs-prompt/zshrc.sh ] || { echo '...skip'; return; }

source ~/.zsh/plugins/zsh-vcs-prompt/zshrc.sh

# Unabale using python.
#ZSH_VCS_PROMPT_USING_PYTHON='false'
## Enable caching.
ZSH_VCS_PROMPT_ENABLE_CACHING='true'
## Logging level.
ZSH_VCS_PROMPT_LOGGING_LEVEL='2'
## Set threshhold micro seconds.
#ZSH_VCS_PROMPT_LOGGING_THRESHOLD_MICRO_SEC=350000  # 350ms
ZSH_VCS_PROMPT_GIT_FORMATS_USING_PYTHON="${ZSH_VCS_PROMPT_GIT_FORMATS}"
ZSH_VCS_PROMPT_GIT_FORMATS+='!'
ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='!'
