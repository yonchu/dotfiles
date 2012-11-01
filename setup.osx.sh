#!/bin/sh

# 未設定の変数を参照するとエラー
set -u

# 実行確認
confirm_exe() {
    echo -n "$1 (y/n) --> "
    read yn
    case $yn in
        y|Y)
            echo '実行します...'
            return 0
            ;;
        *)
            echo '中止しました'
            return 1
            ;;
    esac
}

create_dotfiles() {
    (
        cd ~/
        git clone git@github.com:yonchu/dotfiles.git
        [ $? -ne 0 ] && return 1
        cd ~/dotfiles
        git submodule update --init
        [ $? -ne 0 ] && return 1
        git submodule foreach "git checkout master"
        echo '--- 確認 ----'
        ~/dotfiles/bin/gits
    )
}

setup_vim() {
    vim -c NeoBundleInstall -c quit
}

create_symlink() {
  if [ -e "$2" ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s "$1" "$2"
    echo "シンボリックリンクを作成しました: $file"
  fi
}

create_dotfiles_symlinks() {_
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

    # .dir_colors
    ln -s .zsh/dircolors-solarized/dircolors.ansi-universal "$HOME.dir_colors"
}


## Main --------------------

# ライブラリディレクトリを表示
chflags nohidden ~/Library/

# dotfilesを作成
confirm_exe 'dotfilesを作成しますか？' && create_dotfiles

# vim(NeoBundle)の設定
confirm_exe 'vimの設定を行いますか？' && setup_vim

# シンボリックリンク作成
confirm_exe 'シンボリックリンクを作成しますか？' && create_dotfiles_symlinks

## complete message
echo 'Setup completed!'
