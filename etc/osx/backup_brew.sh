#!/bin/bash

set -u

# 実行確認
exe_confirm() {
    echo 'バックアップを行います。'
    echo -n '既存のファイルは上書きされますがよろしいですか？ (y/n) --> '
    read yn
    case $yn in
    y|Y) ;;
    *)   echo 'バックアップを中止しました。'
         exit 1;;
esac
}
# 実行確認
exe_confirm

## Main --------------------

echo "$(date)"

## Installed packages
brew list -1 > brew_list.txt

## tap list
brew tap > brew_tap.txt

## complete message
echo 'Backup completed!'
