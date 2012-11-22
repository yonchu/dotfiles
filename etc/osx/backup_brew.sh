#!/bin/bash
# 未定義の変数を使用するとエラー
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

## homebrew
{
    echo "$(date)"
    echo '===== brew list --versions ====='
    brew list --versions
    echo
    echo '===== brew tap ====='
    brew tap
} > brew_info.txt


## complete message
echo 'Backup completed!'
