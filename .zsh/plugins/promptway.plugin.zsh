#
# promptway
#
#  https://github.com/pasberth/promptway
#

[ -f ~/.zsh/promptway/promptway.zsh ] || { echo '...skip'; return; }

if ! (type realpath || type grealpath) > /dev/null 2>&1; then
    echo '...skip (command not found: realpath or grealpath)'
    return
fi

source ~/.zsh/promptway/promptway.zsh

zstyle ':prompt:way' formats "%a"
zstyle ':prompt:dir' formats "%F{red}%a%f"
zstyle ':prompt:dir:symlink' formats "%B%F{cyan}%a@%f%b"
zstyle ':prompt:backward' enable t
zstyle ':prompt:backward:dir' formats "%U%a%u"
zstyle ':prompt:backward:dir:symlink' formats "%U%F{cyan}%a@%f%u"
zstyle ':prompt:backward:way' formats "%a"

function _update_prompt_way() {
  promptway
  PROMPT_WAY=$_prompt_way
  PROMPT_BACKWARD=$_prompt_backward
}
add-zsh-hook chpwd _update_prompt_way
_update_prompt_way
