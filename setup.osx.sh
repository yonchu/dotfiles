#!/bin/sh

# 未設定の変数を参照するとエラー
set -u

## 各種シンボリックリンク作成
#
DOT_FILES=(.ackrc .bashrc .bash_profile .dir_colors .gitconfig .gitignore .gitk .gvimrc .inputrc .lv .my.cnf .pythonstartup .screenrc .ssh .tmux.conf .vim .vimrc .zprofile .zsh .zshrc)

(
cd ~/
for file in ${DOT_FILES[@]}; do
  if [ -e $HOME/$file ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s dotfiles/$file $file
    echo "シンボリックリンクを貼りました: $file"
  fi
done
)

