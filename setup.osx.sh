#!/bin/sh

# 未設定の変数を参照するとエラー
set -u


## OSX Lion インストール
#  Xcode4,x のインストール
#  Command Line Tools のインストール
#
#  Xcodeのパスを確認
#  $ xcode-select -print-path
#
#  変更(/Developer になっている場合)
#  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
#  $ xcrun -find cc
#  $ xcrun -find gcc
#  $ xcrun -find clang
#


## dotfilesの準備
#
# dotfilesをgithubより持ってくる
# $ cd ~/
# $ git clone xxxxx
# $ git status
#
# $ git submodule status
# $ git submodule update --init
# $ cd <サブモジュールディレクトリ>
# $ git branch
# * (no branch)
#   master
# $ git checkout master
#



## Homebrew 導入
#
# /usr/local/のパーミッションを root:staff に変更
#
# https://github.com/mxcl/homebrew/wiki/installation
#
# homebrewのインストール
# $ /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
#
# PATHを手動で一時的に変更
#   /usr/local/bin/, /usr/local/sbin/, /usr/local/share
#   export PATH=/usr/local/bin/:/usr/local/sbin/:/usr/local/share:$PATH
#
# Gitインストール
# $ brew install git
#
# アップデート
# $ brew update
#
# 確認
# $ brew doctor
# $ brew --config
# $ brew --env
#
# 外部リポジトリ追加
# $ brew tap homebrew/dupes
# $ brew tap homebrew/versions
# $ brew tap adamv/homebrew-alt
# 確認
# $ brew tap
#
# tomcat6.rbを追加
#
# パッケージインストール
# - インストール対象は別リスト
# Python以外をインストール
# fontforgeが正常に動作する確認
# $ fontforge  -script fontpatcher azuki.ttf
#
# homebrewの補完関数_brewを設定
# $ cd /usr/local/share/zsh/functions
# $ ln -s ../../../Library/Contributions/brew_zsh_completion.zsh _brew
#


## 各種シンボリックリンク作成
#
DOT_FILES=(.ackrc .bashrc .bash_profile .dir_colors .gitconfig .gitignore .gitk .gvimrc .inputrc .lv .my.cnf .screenrc .tmux.conf .vim .vimrc .zprofile .zsh .zshrc)

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

## ターミナルの再起動


## vim
#
# MacVim-KaoriYa インストール
#  http://code.google.com/p/macvim-kaoriya/
#
# vundleによるvimプラグインのインストール
# $ cd ~/.vim
# $ mkdir bundle
# $ cd bundle
# $ git clone https://github.com/gmarik/vundle.git
#
# $ vim -c BundleInstall -c quit
# $ vim test.py BundleInstall -c quit
#
# vimprocのコンパイル
# $ cd ~/.vim/bundle/vimproc/
# $ make -f make_mac.mak
#
# vim-powerlineの個別変更(キャラコード/文字数(マルチ文字対応))
# :PowerLineClearCache
# フォントのインストール
#  Ricty,  Envy Code R, うにフォント, あずきフォント
#


# ★ 入念に動作確認


## ログインシェルをzshに変更
#
#  現在のログインシェルを確認
#  $ chpass
#
#  ログインシェルに設定可能なシェルの一覧を確認
#  $ cat /etc/shells
#
#  ログインシェルの一覧の最終行に /usr/local/bin/zsh を追加
#  $ sudo vi /etc/shells
#
#  ログインシェルをzshに変更
#  $ chpass -s /usr/local/bin/zsh
#
#  変更の確認
#  $ chpass
#
#  OSを再起動
# 「システム環境設定」→「ユーザーとグループ」で、アカウントを右クリック、
# 「詳細オプション」を表示して、ログインシェルが変更されていれば成功です。
#


## screen256colorのインストール
#
# $ cd ~/work/usr/local/src
# $ cd ~/work/usr/local/src
# $ mkdir screen
# $ cd screen
#
# http://www.frexx.de/xterm-256-notes/ より 256colors2.pl をDL
# $ curl -OLv http://www.frexx.de/xterm-256-notes/data/256colors2.pl
# $ ./256color2.pl
#
# $ git clone git://git.sv.gnu.org/screen.git
# $ cd screen/rc
# $ sudo ./autogen.sh
# $ sudo ./autoheader.sh
# ($ ./autogen.sh)
# $ ./configure --prefix=~/work/usr/local --enable-colors256
# $ make
# $ make install
#
# $ ~/work/usr/local/bin/screen
# $ 245color.pl
#
# ~/binにシンボリックリンクを作成
# $ cd ~/bin
# $ ln -s ~/work/usr/local/bin/screen screen
#


## ターミナル
#
# Terminal.appの設定変更
# iTerm2のインストールとバックアップから設定復旧
#


## 日本語man(jman)をインストール
#   http://www.fan.gr.jp/~sakai/softwares/unix
#
#  $ cd ~/work/usr/src/
#  $ mkdir jman
#  $ cd jman
#  $ curl -LOv http://www.fan.gr.jp/~sakai/files/jman-20080103r2.dmg
#  $ curl -LOv http://www.fan.gr.jp/~sakai/files/manpages-ja_JP-20080103r2.dmg
#
# /usr/local/jman 以下に必要なファイルがインストールされ、
# /usr/local/bin にjmanコマンドがインストールされる



## MacAPPをインストール
# - スティッキーズの内容復元
# - Google IME - 不要なモードOFF、ESCなどでIME-OFF
# - KeyRemap4MacBook の設定復元
# - ClipMenu の内容復元
# - Eclipse の復元
# - KeyBindings の復元
# - workflow/scripts の復元
# etc...その他は別リストで
#

## DashboardのWidgetをインストール
# - iCalのカラー版
# - tunesText
# - ニコ生Widget
# - 週間天気
# - 辞書
# - 翻訳
# - TeleMania(TV番組表)
# - DeepSleep
# - 電卓
#


## sshの設定
# .ssh/config
#  公開鍵/秘密鍵
#  authorized_keys


## pythonbrew
#   詳しくはBlogで
#

# clamxav : ウィルス対策
# MySQL
# Ecliplse + jad
# VirtualBox + CentOSなど



## ディレクトリ構成の復活
#  詳しくはバックアップのディレクトリ構成参照
#  $HOME/
#  $HOME/Documents
#  $HOME/Downloads
#  $HOME/work
#  $HOME/work/dev
#  $HOME/work/tips
#  $HOME/work/usr
#  $HOME/work/usr/local
#  $HOME/work/usr/src
#  /usr/local


# DropBoxによる共有情報の確認とバックアップからの復元


# gccのインストール
#  手動 or 非公式インストーラ or homebrew
#  http://holidayworking.org/memo/2011/12/29/1/
#  http://toggtc.hatenablog.com/entry/2012/01/28/224006


# dotfile.localをDropBox上のリモートリポジトリよりクローン
# 個別環境に応じて設定を変更(適当)
