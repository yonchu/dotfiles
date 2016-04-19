Setup Manual for Mac OS X
======================

Mac OS X セットアップ時の環境設定方法について記載する。

個人的なメモ書きのため、作者以外にはあまり参考になりません。

#### 条件

 * OS X 10.10(Yosemite) or later


#### 必要なもの

 * DropBox内のバックアップ
 * Evernote内のインストール情報


設定項目
--------

## Homebrew をインストール

[Homebrew — The missing package manager for OS X](http://brew.sh/)
[README](https://github.com/Homebrew/homebrew/tree/master/share/doc/homebrew#readme)

上記ページを参考に Homebrew 本体をインストール

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    $ ls -la /usr
    drwxrwxr-x    13 root  admin    442 Jun  2 14:20 local

setup_brew.sh を実行

    $ ~/dotfiles/etc/osx/setup_brew.sh

APIトークンの設定

    $ vi ~/.brew_api_token
    export HOMEBREW_GITHUB_API_TOKEN=xxxxx


## dotfiles のセットアップ

    $ git clone --recursive https://github.com/yonchu/dotfiles.git
    $ cd ~/dotfiles/ && ./etc/setup.sh

zsh, bash のヒストリーファイルの移行


## /etc/zshenv を /etc/zprofile に変更 (OS X 10.7 or later)

OS X が10.7にアップデートした時に誤って,
/etc/zprofile を /etc/zshenv にしてしまったらしい。


zshをサブシェルとして実行するとPATHの設定がおかしくなってしまう。
また、zshでスクリプトを実行した場合もPATHがおかしくなってしまう。

    $ brew info zsh
    ….
    If you have administrator privileges, you must fix an Apple miss
    configuration in Mac OS X 10.7 Lion by renaming /etc/zshenv to
    /etc/zprofile, or Zsh will have the wrong PATH when executed
    non-interactively by scripts.

    Alternatively, install Zsh with /etc disabled:

      brew install --disable-etcdir zsh

よって、下記コマンドで zsh をインストールする。

    $ brew install --disable-etcdir zsh

または、以下のように変更する。

    $ ls -l /etc/zshenv
    -r--r--r--   1 root wheel  126 2012-04-06 03:56 zshenv
    $ sudo mv /etc/zshenv /etc/zprofile
    $ ls -l /etc/zprofile
    -r--r--r--   1 root wheel  126 2012-04-06 03:56 zprofile


## bash/zsh の設定ファイルについて

 - zsh
    - ~/.zshenv
    - ZDOTDIR/.zprofile
        - \-> ~/dotfiles/.profile
        - \-> ~/dotfiles/.profile.osx
    - ZDOTDIR/.zshrc
        - \-> ~/.zsh/.zprompt
        - \-> ~/dotfiles/.alias
        - \-> ~/.zsh/.zalias
        - \-> ~/dotfiles/.shrc.local
    - ZDOTDIR/.login


 - bash
    - ~/.bash\_profile
        - \-> ~/dotfiles/.profile
        - \-> ~/dotfiles/.profile.osx
    - ~/.bashrc
        - \-> ~/dotfiles/.alias
        - \-> ~/dotfiles/.shrc.local



## ログインシェルを zsh に変更

ログインシェル変更前に入念に動作チェックを行う。

現在のログインシェルを確認

    $ chpass

ログインシェルに設定可能なシェルの一覧を確認

    $ cat /etc/shells

ログインシェルの一覧の最終行に /usr/local/bin/zsh を追加

    $ sudo vi /etc/shells

ログインシェルをzshに変更

    $ chpass -s /usr/local/bin/zsh

変更の確認

    $ chpass

OSを再起動し、「システム環境設定」→「ユーザーとグループ」で、アカウントを右クリック、
「詳細オプション」を表示して、ログインシェルが変更されていれば成功。


## screen256colorのインストール

    $ cd ~/work/usr/local/src
    $ cd ~/work/usr/local/src
    $ mkdir screen
    $ cd screen

[ここ](http://www.frexx.de/xterm-256-notes/) から 256colors2.pl をDL

    $ curl -OLv http://www.frexx.de/xterm-256-notes/data/256colors2.pl
    $ ./256color2.pl

screenの最新版をGithubからCloneし、インストール

    $ git clone git://git.sv.gnu.org/screen.git
    $ cd screen/rc
    $ sudo ./autogen.sh
    $ sudo ./autoheader.sh
    ($ ./autogen.sh)
    $ ./configure --prefix=~/work/usr/local --enable-colors256
    $ make
    $ make install

screenを実行した状態で 256colors2.pl を実行して確認

    $ ~/work/usr/local/bin/screen
    $ ./256color2.pl

~/binにシンボリックリンクを作成

    $ cd ~/bin
    $ ln -s ~/work/usr/local/bin/screen screen


## ターミナル

Terminal.appの設定変更

iTerm2をインストールし、バックアップから設定を復旧

 * ~/Library/Preferences/com.googlecode.iterm2.plist


## 日本語man(jman)をインストール

下記サイトより、必要なファイルをDLしてインストール

 <http://www.fan.gr.jp/~sakai/softwares/unix>

    $ cd ~/work/usr/src/
    $ mkdir jman
    $ cd jman
    $ curl -LOv http://www.fan.gr.jp/~sakai/files/jman-20080103r2.dmg
    $ curl -LOv http://www.fan.gr.jp/~sakai/files/manpages-ja_JP-20080103r2.dmg

DLしたファイルを実行

/usr/local/jman 以下に必要なファイルがインストールされ、 /usr/local/bin にjmanコマンドがインストールされる。


## 日本語man(JM Project - Linxu/GNU系)をインストール

下記サイトより全体アーカイブをDL

[JM Project (Japanese)](http://linuxjm.sourceforge.jp/)

    $ make config
    perl -w script/configure.perl
    [INSTALLATION INFORMATION]
    (just Return if you accept default)
    Install directory   [/usr/share/man/ja_JP.UTF-8] ?: /Users/<username>/work/usr/local/share/man/ja_JP.UTF-8
    compress manual with..
      0: none
      1: gzip
      2: bzip2
      3: compress
    select [0..3] : 0
    uname of page owner [root] ?: <username>
    group of page owner [root] ?: staff

       Directory:    /Users/<username>/work/usr/local/share/man/ja_JP.UTF-8
       Compression:  none
       Page uid/gid: <username>/staff

    All OK? (Yes, [C]ontinue / No, [R]eselect) : c

    以下全て Enter or c -> Enter


## MacAPPをインストール

 - Stickies.app の内容復元
 - Karabiner.app の設定復元
 - ClipMenu の内容復元
 - etc (その他のアプリはEvernote参照)


## DashboardのWidgetをインストール

 - iCalのカラー版
 - TunesTEXT
 - ニコ生Widget
 - 週間天気
 - 辞書
 - 翻訳
 - TeleMania(TV番組表)
 - DeepSleep
 - 電卓
 - 鉄道運行情報
 - iStat Pro
 - Kitchen Timer


## sshの設定

 - .ssh/config
 - 公開鍵/秘密鍵
 - authorized\_keys


## pyenv のインストール

Evernoteのメモを参照

    $ pip freeze
    autopep8
    debug
    distribute
    flake8
    flake8_docstrings
    ipython
    pep8
    pudb
    pyflakes
    readline
    wsgiref
    see

## ruby(rvm/gem)

Evernoteのメモを参照

    $ gem list
    git-browse-remote
    rvm
    tw


## gccのインストール

 手動 or 非公式インストーラ or homebrew

 <http://holidayworking.org/memo/2011/12/29/1/>

 <http://toggtc.hatenablog.com/entry/2012/01/28/224006>


## dotfile.local

dotfiles.local をDropBox上のリモートリポジトリよりクローン

個別環境に応じて設定を変更


<!-- vim:set ft=markdown: -->
