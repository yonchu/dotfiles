"*******************************************************************************
"
" .gvimrc
"   GUI版vimの設定ファイル
"
"*******************************************************************************

" solarized settings
let g:solarized_termcolors=256   "default value is 16
let g:solarized_contrast="high"  "default value is normal
syntax enable
set background=dark              " dark or light
colorscheme solarized            " カラースキーマ
let g:solarized_termcolors=256   " 256色(solarizedスキーマ専用)

" IM自動制御 (GUI専用)
" http://blogger.splhack.org/2011/01/macvim-kaoriya-20110111.html
set imdisableactivate            " ESCでIM自動OFF、入力モードでIM自動OFF
"set noimdisableactivate          " ESCでIM自動OFF、入力モードでIM自動ON
"set imdisable                    " IM自動制御OFF


set cmdheight=2                  " コマンドラインの高さ(GUI使用時)

if has('mac')
  set transparency=5               " opacity:透過度
  set antialias                    " アンチエイリアス

  " フォント(Regular Font)
  "set guifont=Osaka-Mono:h13
  "set guifont=Monaco:h13
  "set guifont=Ricty-RegularForPowerline:h14
  set guifont=EnvyCodeRForPowerline:h14

  " Non-ACSII Font
  "set guifontwide=Osaka-Mono:h13
  set guifontwide=Ricty-Regular:h14

  set columns=100                  " width (列)
  set lines=35                     " line (行)
elseif has('linux')
  set guifont=Monaco\ 12
  set columns=100
  set lines=35
endif

set spell                        " スペルチェック

" カーソルラインのカラー設定 GUI版
hi clear CursorLine
hi CursorLine gui=underline

" マウス関係
set nomousefocus                 " マウス移動によるフォーカス切り替えを無効
set guioptions+=a                " GUI版vimでもマウス選択機能有効
