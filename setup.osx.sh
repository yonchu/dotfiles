#!/bin/sh

# 未設定の変数を参照するとエラー
set -u

create_symlink() {
  if [ -e "$2" ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s "$1" "$2"
    echo "シンボリックリンクを作成しました: $file"
  fi
}

## 各種シンボリックリンク作成
#
DOT_FILES=(.ackrc .bashrc .bash_profile .dir_colors .gitconfig .gitignore .gitk .gvimrc .inputrc .lv .my.cnf .pythonstartup .screenrc .ssh .tmux.conf .vim .vimrc .zsh)

for file in ${DOT_FILES[@]}; do
    create_symlink "dotfiles/$file" "$HOME/$file"
done

# .zshenv
ln -s .zsh/.zshenv "$HOME/.zshenv"

# .gitignore
ln -s dotfiles/.gitignore.default "$HOME/.gitignore"
