Setup Manual for Mac OS X
======================

Mac OS X セットアップ時の環境設定方法について記載する。

個人的なメモ書きのため、作者以外にはあまり参考になりません。

#### 条件
 * OS X 10.6 or later


#### 必要なもの
 * DropBox内のバックアップ
 * Evernote内のインストール情報


設定項目
--------
## ライブラリディレクトリの表示

    $ chflags nohidden ~/Library/


## Xcode と Command Line Tools for Xcode のインストール

#### インストール手順

1. Xcode をAppStoreからインストール
1. Command Line Tools のインストール
    * Xcodeを起動し、メニューから [Xcode] > [Preferences] > [Downloads] を開き、Command Line Tools をインストール


#### 確認

Xcodeのパスを確認

    $ xcode-select -print-path

Xcodeのパスが /Developer になっている場合は変更する

    $ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

Xcodeのパス変更を確認

    $ xcrun -find cc
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc
    $ xcrun -find gcc
    /Applications/Xcode.app/Contents/Developer/usr/bin/gcc
    $ xcrun -find clang
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang


## dotfilesの準備

dotfilesをgithubより取得

    $ cd ~/
    $ git clone https://github.com/yonchu/dotfiles.git
    $ git status

サブモジュールの取得

    $ cd ~/dotfiles
    $ git submodule status
    $ git submodule update --init
    $ cd <サブモジュールディレクトリ>
    $ git branch
    * (no branch)
      master
    $ git checkout master
    $ git branch
    * master

シンボリックリンクを作成

    $ ~/dotfiles/setup.osx.sh


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
    - ~/.bash_profile
        - \-> ~/dotfiles/.profile
        - \-> ~/dotfiles/.profile.osx
    - ~/.bashrc
        - \-> ~/dotfiles/.alias
        - \-> ~/dotfiles/.shrc.local


## Homebrew 導入

参考
[Macのパッケージ管理をMacPortsからhomebrewへ - よんちゅBlog](http://yonchu.hatenablog.com/entry/20110226/1298723822)

既に /usr/local が作成済みの場合は、/usr/local の所有権限を root:staff に変更

    $ chown root:staff /usr/local

homebrewのインストール

    $ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

PATHを手動で一時的に変更

    $ export PATH=/usr/local/bin/:/usr/local/sbin/:/usr/local/share:$PATH

Gitインストール

    $ brew install git

アップデート

    $ brew update

確認

    $ brew doctor
    $ brew --config
    $ brew --env

外部リポジトリ追加

    $ brew tap homebrew/dupes
    $ brew tap homebrew/versions
    $ brew tap adamv/homebrew-alt
    $ brew tap homebrew/boneyard

確認

    $ brew tap

tomcat6.rbを追加(バックアップより)

パッケージインストール

2. Python以外のパッケージをインストール
2. fontforgeが正常に動作するか確認
    $ fontforge  -script fontpatcher azuki.ttf
2.  最後にPythonをインストール

homebrewの補完関数\_brewを設定

    $ cd /usr/local/share/zsh/functions
    $ ln -s ../../../Library/Contributions/brew_zsh_completion.zsh _brew

## vim

MacVim-KaoriYa インストール

[macvim-kaoriya - MacVim KaoriYa - Google Project Hosting](http://code.google.com/p/macvim-kaoriya/)

vundleによるvimプラグインのインストール

    $ cd ~/.vim
    $ mkdir bundle
    $ cd bundle
    $ git clone https://github.com/gmarik/vundle.git

    $ vim -c BundleInstall -c quit
    $ vim test.py -c BundleInstall -c quit

vimprocのコンパイル

    $ cd ~/.vim/bundle/vimproc/
    $ make -f make_mac.mak

vim-powerlineの個別変更(キャラコード/文字数(マルチ文字対応))

    ~/dotfiles/.vim/bundle/vim-powerline/autoload/Powerline/Segments.vim
    - \ Pl#Segment#Create('line.cur'    , '$LINE %3l'),
    - \ Pl#Segment#Create('line.tot'    , ':%-2v', Pl#Segment#NoPadding()),
    + \ Pl#Segment#Create('line.cur'    , '$LINE %3l/%-3L'),
    + \ Pl#Segment#Create('line.tot'    , ':%-3v', Pl#Segment#NoPadding()),

    ~/dotfiles/.vim/bundle/vim-powerline/autoload/Powerline/Themes/default.vim b/autoload/Powerline/Themes/default.vim
      \ , 'virtualenv:statusline'
    + \ , 'charcode'
      \ , 'fileformat'

vim-powerline対応のフォントをインストール

Ricty,  Envy Code R, うにフォント, あずきフォント
<br><br>
vim-powerlineのキャッシュクリア

    $ vim -c PowerLineClearCache -c quit



## 動作確認

ログインシェル変更前に入念に動作チェックを行う。

## ログインシェルをzshに変更

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


## MacAPPをインストール

 - スティッキーズの内容復元
 - Google IME - 不要なモードOFF、ESCなどでIME-OFF
 - KeyRemap4MacBook の設定復元
 - ClipMenu の内容復元
 - Eclipse の復元
 - KeyBindings の復元
 - workflow/scripts の復元
 - CotEditorの復元
 - clamxav
 - MySQL
 - Ecliplse + jad
 - VirtualBox + CentOSなど
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


## pythonbrew

Evernoteのメモを参照


## ディレクトリ構成の復活

 - $HOME/
 - $HOME/Documents/\*
 - $HOME/work
 - $HOME/work/dev
 - $HOME/work/tips
 - $HOME/work/usr
 - $HOME/work/usr/local
 - $HOME/work/usr/src
 - /usr/local


## その他DropBoxのバックアップから復元


## gccのインストール

 手動 or 非公式インストーラ or homebrew

 <http://holidayworking.org/memo/2011/12/29/1/>

 <http://toggtc.hatenablog.com/entry/2012/01/28/224006>


## dotfile.local

dotfiles.local をDropBox上のリモートリポジトリよりクローン

個別環境に応じて設定を変更(適当)


## Sublime Text 2 のインストール

DropBoxから設定を復元

    $ cd ~/Library/Application Support
    $ mv Sublime\ Text\ 2 ~/.Trash
    $ ln -s $HOME/Dropbox/Repos/Apps/Sublime\ Text\ 2 Sublime\ Text\ 2

実行ファイルのシンボリックリンクを作成

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl ~/bin/subl
