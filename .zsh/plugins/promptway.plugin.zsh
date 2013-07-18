#
# promptway
#
#  https://github.com/pasberth/promptway
#

[ -f ~/.zsh/plugins/promptway/promptway.zsh ] || { echo '...skip'; return; }

if ! (type realpath || type grealpath) > /dev/null 2>&1; then
    echo '...skip (command not found: realpath or grealpath)'
    return
fi

source ~/.zsh/plugins/promptway/promptway.zsh

zstyle ':prompt:way' formats "%a"
zstyle ':prompt:dir' formats "%F{red}%a%f"
zstyle ':prompt:dir:symlink' formats "%B%F{cyan}%a@%f%b"
zstyle ':prompt:backward' enable t
zstyle ':prompt:backward:dir' formats "%U%a%u"
zstyle ':prompt:backward:dir:symlink' formats "%U%F{cyan}%a@%f%u"
zstyle ':prompt:backward:way' formats "%a"

zstyle ':prompt:truncate' enable t
zstyle ':prompt:truncate' symbol '… '
# zstyle ':prompt:truncate' max_length 30

zstyle ":prompt:truncate" show_working_parent t
# zstyle ":prompt:truncate" show_backward_parent t
zstyle ":prompt:truncate" show_slash_second_root t
zstyle ":prompt:truncate" show_home_second_root t

#$_prompt_way/$_prompt_backward
add-zsh-hook chpwd promptway
promptway
