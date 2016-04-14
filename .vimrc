" ============================================================================
"
"  .vimrc
"
" ============================================================================

" === Initialization ====================================================={{{1
" :qaSkip initialization for vim-tiny or vim-small.
if 0 | endif

" viとの互換性をとらない (vim独自の拡張機能を使用する為)
set nocompatible

if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif

" OS判定フラグ
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \ || (!executable('xdg-open') && system('uname') =~? '^darwin'))

" 言語指定
if s:is_windows
  " For Windows.
  language messages ja_JP
elseif s:is_mac
  " For Mac.
  language messages ja_JP.UTF-8
  language ctype ja_JP.UTF-8
  language time ja_JP.UTF-8
else
  " For Linux.
  language messages C
endif

" ヘルプファイル指定
"set helpfile=$VIMRUNTIME/doc/help.txt
" ヘルプの言語を指定(日本語を優先)
set helplang& helplang=ja,en

" 起動時のメッセージを表示しない
set shortmess& shortmess+=I
"set shortmess=aTI

" <Leader>キーを変更 (default: \)
let g:mapleader = ','
" <LocalLeader>キーを変更
" Filetype plug-in で使用することで Global plug-in とのマッピング衝突を避ける
"let g:maplocalleader = '\'

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

" パス区切りをスラッシュに変更
if s:is_windows && exists('+shellslash')
  set shellslash
endif

" vimディレクトリへのパスを保持 (OSによって異なるため)
"   Windows : $VIM/vimfiles
"   Linux/Mac : ~/.vim
let $DOTVIM = expand('~/.vim')

" .gvimrc へのパスを設定
if !exists('$MYGVIMRC')
  let $MYGVIMRC = expand('~/.gvimrc')
endif

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:set_default(var, val)
  if !exists(a:var) || type({a:var}) != type(a:val)
    silent! unlet {a:var}
    let {a:var} = a:val
  endif
endfunction

" HOME directory.
let t:cwd = getcwd()

augroup MyAutoCmd
  autocmd!
augroup END

" Disable default plugins
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1

" }}}


" === Dein Settings ================================================={{{1

" === Information {{{2
" https://github.com/Shougo/dein.vim
"
" Directory:
"   dein root: /.vim/dein
"   dein repo: /.vim/dein/repos/github.com/Shougo/dein.vim
" Plugin List:
"   default: /.vim/rc/dein.toml
"   lazy   : /.vim/rc/deinlazy.toml
" Plugin Detail Settings:
"   /.vim/rc/plugins/*
" =========================================================================}}}

" === Dein Initialization {{{2
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml_path = '~/.vim/rc/dein.toml'
let s:toml_lazy_path = '~/.vim/rc/deinlazy.toml'

" Load dein.
if &runtimepath !~# '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      echoerr '[ERROR] Stop reading .vimrc: dein.vim not installed.'
      " execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
      finish
    endif
  endif
  " Set runtimepath.
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_repo_dir, ':p'), '/$', '', '')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])

  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})

  call dein#end()
  call dein#save_state()

  if has('vim_starting') && !has('gui_running') && expand('%') ==# '.vimrc'
    if dein#check_install()
      " Installation check.
      call dein#install()
    endif
  endif
endif

" }}}

" }}}


" === Basic Settings ====================================================={{{1

" === Encoding {{{2

"  http://d.hatena.ne.jp/ka-nacht/20080220/1203433500
"  http://www.kawaz.jp/pukiwiki/?vim#cb691f26
"  http://d.hatena.ne.jp/over80/20080907/1220794834
"
"  encoding
"   vim内部で使用する文字コード
"   バッファ/レジスタ/vimスクリプトなどの文字列に適用される
"   vim全体で共通のグローバルオプション
"   新規ファイル作成時にfileencodingが未指定の場合にも使用される
"
"  fileencoding
"   新規ファイル作成時またはバッファ保存時に使用される文字コード
"   (ファイルの文字コードと言えばこの値を指す)
"   バッファ毎に指定可能なバッファローカルオプション
"   encodingと異なる場合は保存時にfileencodingへ変換される
"   fileencodingを変更したい場合は setlocal にて変更する必要がある
"   set にて変更した場合はグローバル値が変更されるため、以降に新規作成される
"   バッファの保存時に適用される文字コードが変わってしまう
"
"  fileencodings
"   文字コードの自動判別優先順位
"   カンマ区切りで指定され、左側の設定が優先される
"   判別方法は左から順に変換を行い最初に成功した値が適用される
"   変換途中にencodingまたはfileencodingと同じ値を発見した場合は判定を中断し
"   その値を適用する
"   自動判別に失敗した場合は encoding の値が適用される
"
"  fileformat
"   改行コード(unix=LF, dos=CRLF, mac=CR)
"
"  fileformats
"   改行コードの自動判別優先順位
"

set encoding=utf-8

" termencoding 設定
" https://github.com/Shougo/shougo-s-github
if !has('gui_running')
  if &term ==# 'win32' &&
        \ (v:version < 703 || (v:version == 703 && has('patch814')))
    " Setting when use the non-GUI Japanese console.
    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this.  Be careful because the
    " automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:is_windows
  " For system.
  set termencoding=cp932
endif

" fileencodings 設定
" https://github.com/Shougo/shougo-s-github
if !exists('did_encoding_settings')
  if has("kaoriya")
    " Kaoriya版ではguess指定で独自の自動判別が可能
    set fileencodings=guess,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
    " Kaoriya版以外では banyan/recognize_charcode.vim にて文字コードを判定
    " https://github.com/banyan/recognize_charcode.vim
  elseif has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    " Does iconv support JIS X 0213?
    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213,euc-jp'
      let s:enc_jis = 'iso-2022-jp-3'
    endif

    " Build encodings.
    let &fileencodings = 'ucs-bom'
    if &encoding !=# 'utf-8'
      let &fileencodings = &fileencodings . ',' . 'ucs-2le'
      let &fileencodings = &fileencodings . ',' . 'ucs-2'
    endif
    let &fileencodings = &fileencodings . ',' . s:enc_jis

    if &encoding ==# 'utf-8'
      let &fileencodings = &fileencodings . ',' . s:enc_euc
      let &fileencodings = &fileencodings . ',' . 'cp932'
    elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      let &encoding = s:enc_euc
      let &fileencodings = &fileencodings . ',' . 'utf-8'
      let &fileencodings = &fileencodings . ',' . 'cp932'
    else  " cp932
      let &fileencodings = &fileencodings . ',' . 'utf-8'
      let &fileencodings = &fileencodings . ',' . s:enc_euc
    endif
    let &fileencodings = &fileencodings . ',' . &encoding

    unlet s:enc_euc
    unlet s:enc_jis

    let did_encoding_settings = 1
  endif
endif

set fileformat=unix
set fileformats=unix,dos,mac

" □や◯文字があってもカーソル位置がずれないように
" Win版Kaoriyaではautoが使用可能
if &ambiwidth !=# 'auto'
  set ambiwidth=double
endif

" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bk,.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" バッファ読み込み時のencoding判別
function! s:ReCheck_FENC()
  " iso-2022-jp と判定された場合でも、
  " 日本語が含まれなければ、encoding の値を使用
  if &fileencoding =~# 'iso-2022-jp' &&
        \ search("[^\x01-\x7e]", 'n', 100, 100) == 0
    let &fileencoding=&encoding
  endif
endfunction
autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" insertモードを抜けるとIMEオフ
" Mac では KeyRemap4MacBook にて対応
"  http://d.hatena.ne.jp/r7kamura/20110217/1297910068
if has('multi_byte_ime')
  " Win32 IME サポート有り
  set noimdisable               " IMを無効化
  " im***=n
  "   0:日本語モード(Input Method)OFF
  "   1:lmapをONにしてIMをOFFにする
  "   2:lmapをOFFにしてIMをONにする
  set iminsert=0                " 入力モードで日本語入力OFF
  set imsearch=0                " 検索モードで日本語入力OFF
  set noimcmdline               " コマンドラインで日本語入力OFF
endif

" }}}

" === Basic {{{2

set scrolloff=7                  " スクロール時の余白確保
set virtualedit& virtualedit+=block  " 矩形選択で自由に移動する
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set browsedir=buffer             " Exploreの初期ディレクトリ
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set isfname-==                   " ファイル名に含まれる文字を指定(=を含まない)
set updatetime=1000              " CursorHold time
set keywordprg=:help             " コマンド K で使用されるプログラム
set spelllang=en_us              " スペルチェック
set report=0                     " 変更行の報告を行う最小行数 (0:必ず報告)
set nostartofline
set switchbuf=useopen            " 既に開いているバッファへジャンプ


"### 全てのベルを抑制
set noerrorbells
set vb t_vb=


"### カーソル移動で行頭/行末から前後の行へ移動可能
"set whichwrap& whichwrap+=h,l,<,>,[,],b,s,~


"### バックスペースキーで削除できるものを指定
"  indent  : 行頭の空白
"  eol     : 改行
"  start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start


"### autoread
" 他で書き換えられたら自動で読み直す
set autoread
" autoread よりも厳密にチェック
autocmd MyAutoCmd WinEnter * checktime
" 編集中でも他のファイルを開けるようにする
set hidden


"### 前回終了したカーソル行に移動
autocmd MyAutoCmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


"### テキストの折り返しを無効
" (textwidth : 入力されているテキストの最大幅, 0指定で折り返し表示を無効)
autocmd MyAutoCmd FileType *
      \ if &l:textwidth != 70 && &filetype !=# 'help' |
      \    setlocal textwidth=0 |
      \ endif


" ### モードライン
" 末尾にモードライン以外の文字を含めない場合
"  # vim: ft=sh sw=4 sts=4 ts=4 et
" 末尾にモードライン以外の文字を含める場合
"  /* vim: set ft=c sw=4 sts=4 ts=4 et: */
set modeline                     " モードラインを有効
set modelines=2                  " モードラインを認識する行数 (前後N行)


"### Completion
" 挿入モードで単語補完
set infercase
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
" コマンド補完候補
"   最長マッチ補完 > リスト表示
set wildmode=longest,list:longest
set history=1000                  " コマンド・検索パターンの履歴数
set complete& complete+=k         " 補完に辞書ファイル追加
set completeopt=menuone   " 補完形式 (menu/menuone/longest/preview)
set pumheight=20                  " ポップアップメニューの最大項目数


"### Folding
set foldenable
" set foldmethod=expr
set foldmethod=marker
" Folding レベル
set foldcolumn=3
set foldnestmax=3
set fillchars=vert:\|
set commentstring=%s


"### ESC後のモード表示の即時反映(msec)
"   http://gajumaru.ddo.jp/wordpress/?p=1076
"   http://gajumaru.ddo.jp/wordpress/?p=1101
"   http://yakinikunotare.boo.jp/orebase2/vim/dont_work_arrow_keys_in_insert_mode
"   https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ibus
"   https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ctrl-hat
" set timeout timeoutlen=1000 ttimeoutlen=75
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=500
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

"### ペースモードを自動解除
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif


"### Conceal.
if v:version >= 703
  " For conceal.
  set conceallevel=2 concealcursor=iv
  set colorcolumn=85
endif

" }}}

" === Search {{{2

set wrapscan                     " 最後まで検索したら先頭へ戻る
set ignorecase                   " 大文字小文字無視
set smartcase                    " 検索文字列に大文字が含まれている場合は区別して検索する
set noincsearch                  " インクリメンタルサーチ
set hlsearch                     " 検索文字をハイライト

" 外部grepの設定(for grep)
"   -i 大文字小文字を区別しない
"   -n 各行の先頭にファイルの行番号を表示します
"   -H ファイル名を表示
"   -E オプションは、拡張正規表現を使用する場合に指定
"      fgrep 正規表現を使わない検索
"      egrep 正規表現を使った検索 -E と同じ
"   -R ディレクトリを再帰的にたどる
"   -I バイナリ検索除外
set grepprg=grep\ -niEH\ $*\ /dev/null

" 外部grepの設定(for ack)
"   -a 全てのファイルから検索(拡張子無しも含む) ただし--TYPEが無効
"   -i 大文字小文字を区別しない
"set grepprg=ack\ -ai

" }}}

" === Clipboard & Mouse {{{2

" OSのクリップボードを有効
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif
" Using the mouse on a terminal.
" http://vim-users.jp/2009/12/hack107/
" http://yskwkzhr.blogspot.jp/2013/02/use-mouse-on-terminal-vim.html
if has('mouse')
  set mouse=a
  " 通常版vimではマウス選択機能を無効にする
  if ! has("kaoriya")
    set mouse-=a
  endif
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    " screenでもマウスを使用できるように
    set ttymouse=xterm2
  endif
endif

" }}}

" === Backup {{{2

" Backup on.
" set backup
" set swapfile
" set backupdir=~/backup

" Backup off.
set nobackup
set noswapfile
" 上書きの保存前にバックアップ生成
" ただし、backup が OFF の場合は、上書きに成功時には削除される
set writebackup

set backupdir-=.
set directory-=.

if has('persistent_undo')
  set undofile
  let &g:undodir=&directory
  autocmd MyAutoCmd BufReadPre * call <SID>set_undofile()
endif
function! s:set_undofile() abort
    let is_git_dir = system('git rev-parse --is-inside-work-tree 2> /dev/null')
    if is_git_dir =~ 'true'
      setlocal noundofile
    endif
endfunction

" }}}

" === Apperance {{{2

set title                        " タイトルをウインドウ枠に表示する
set titlelen=95
set showmatch                    " 括弧の対応をハイライト
set matchtime=3                  " 対応する括弧の表示時間
set matchpairs& matchpairs+=<:>              " 対応する括弧
set number                       " 行番号表示
set list                         " 不可視文字表示:タブ文字を CTRL-I、行末を $ で表示する
set display& display+=uhex,lastline       " 印字不可能文字を16進数で表示
set wrap                         " ウィンドウの幅より長い行は折り返し表示
set cpoptions-=m                 " 対応する括弧のハイライト
set ttyfast                      " 高速ターミナル接続を行う


"### Window.
set splitbelow                   " 横分割時に新しいウィンドウをカレントウィンドウの下に開く
set splitright                   " 縦分割時に新しいウィンドウをカレントウィンドウの右に開く
"set noequalalways                " ウィンドウ分割時にカレントウィンドウのみリサイズ
set winwidth=20                  " ウィンドウの最小幅
set winheight=1                  " ウィンドウの最小高
set previewheight=8
set helpheight=12
set lazyredraw                   " コマンド実行中は再描画しない


"### Command line.
set showcmd                      " 入力中のコマンドをステータスに表示する
set showmode                     " 現在のモードを表示
set laststatus=2                 " 常にステータスラインを表示
set cmdheight=2                  " コマンドラインの高さ
set cmdwinheight=7               " コマンドラインの最大高
set ruler                        " カーソルの位置表示


"### 不可視文字の表示
if s:is_windows
  set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
else
  set listchars=tab:▸\ ,trail:_,extends:»,precedes:«,nbsp:%
endif

"### 折り返し表示
set linebreak
let &showbreak = '> '
set breakat=\ \	!;:,./?


"### View setting.
set viewdir=~/.vim/view
set viewoptions& viewoptions-=options viewoptions+=slash,unix

"### Use autofmt.
" TODO
if exists('autofmt#japanese#formatexpr')
  set formatexpr=autofmt#japanese#formatexpr()
endif


"### モードによってカーソルの形を変更
" 思ったより見づらかったので不可
" t_SI:StartInsert  t_EI:EndInsert
"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"


"### Tab page.
" タブページを表示
"   0: 表示しない
"   1: 2個以上のタブページがあるときのみ表示
"   2: 常に表示
set showtabline=2
" Set tabline.
function! s:my_tabline()
  let s = ''

  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

    " Use gettabvar().
    let title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(bufnr), ':t') :
          \ gettabvar(i, 'title') != '' ?
          \      gettabvar(i, 'title') :
          \      fnamemodify((i == tabpagenr() ?
          \       getcwd() : gettabvar(i, 'cwd')), ':t')

    let title = '[' . title . ']'

    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= title
    let s .= mod
    let s .= '%#TabLineFill#'
  endfor

  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'


" }}}

" === Colors {{{2

" シンタックスON
syntax enable

" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || &term=~"screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm

  " カラー設定読み込み
  if $ITERM_PROFILE =~ "Magica.*"
    source ~/.vim/colors/my-landscape.vim
  elseif $ITERM_PROFILE =~ "Solarized.*"
    source ~/.vim/colors/my-solarized.vim
  else
    source ~/.vim/colors/my-hybrid.vim
  endif
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
  " カラー設定読み込み
  source ~/.vim/colors/my-solarized.vim
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
  " カラー設定読み込み
  source ~/.vim/colors/my-solarized.vim
endif


" For TeraTerm
let s:is_teraterm = 0
if s:is_teraterm
  set term=builtin_linux
  set ttytype=builtin_linux
endif


" ---------- 他のカラー設定をここより前に書かない ----------

" カラーカラムを表示する列
if exists('+colorcolumn')
  set colorcolumn=80
endif

" カーソル行ハイライト
set cursorline

" カレントウィンドウにのみ罫線を引く
autocmd MyAutoCmd WinLeave * set nocursorline
autocmd MyAutoCmd BufEnter,WinEnter,BufRead * set cursorline

" Markdownの_や*のイタリックフォントを無効
autocmd MyAutoCmd FileType markdown hi! def link markdownItalic Normal

"### Clear modeline highlight.
" autocmd MyAutoCmd VimEnter * highlight ModeMsg guifg=bg guibg=bg

" }}}

" === StatusLine {{{2

" vim-powerlineを使用しない場合は以下の設定使用
" ステータスラインに表示する情報の指定
let g:enable_powerline = 1
" Set statusline.
if !g:enable_powerline
  let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
        \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
        \ . "%{expand('%:t:.')}"
        \ . "%{".s:SID_PREFIX()."get_twitter_len()}"
        \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
        \ . "%{printf(' %5d/%d',line('.'),line('$'))}"

  "set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=%3l/%-3L,%3v

  function! s:get_twitter_len()
    return &filetype !=# 'int-earthquake' || mode() !=# 'i' ? '' :
          \ '(rest:' . (140 - len(substitute(vimshell#get_cur_text(),'.','x','g'))) . ')'
  endfunction

  " ステータスラインの色
  highlight StatusLine term=none
        \ guifg=Black   guibg=Gray   gui=none
        \ ctermfg=Black ctermbg=Gray cterm=none

  "入力モード時、ステータスラインのカラーを変更
  autocmd MyAutoCmd InsertEnter * highlight StatusLine
        \ guifg=Black    guibg=DarkYellow    gui=none
        \ ctermfg=Black  ctermbg=DarkYellow  cterm=none
  autocmd MyAutoCmd InsertLeave * highlight StatusLine
        \ guifg=DarkBlue    guibg=Gray    gui=none
        \ ctermfg=DarkBlue  ctermbg=Gray  cterm=none
  "autocmd MyAutoCmd InsertEnter * highlight StatusLine
        "\ guifg=#ccdc90 guibg=#2E4340 ctermfg=cyan
  "autocmd MyAutoCmd InsertLeave * highlight StatusLine
        "\ guifg=#2E4340 guibg=#ccdc90 ctermfg=white
endif

" }}}

" === Indent {{{2

" 自動でインデント
set autoindent
" ペースト時にautoindentを無効
" (onにするとautocomplpop.vimが動かない)
"set paste
" 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set smartindent
" Cプログラム形式の自動インデント
set cindent

" タブが対応する空白数
set tabstop=4
" cindentやautoindent時に挿入されるインデント幅(空白数)
set shiftwidth=4
" Tabキー押し下げ時に挿入される空白数，0の場合はtabstopと同じ，BSにも影響
set softtabstop=4
" タブを挿入するとき、代わりに空白を使わない
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデント
" 行頭以外では 'tabstop' の数だけ空白を挿入
set smarttab
" タブを挿入するとき、代わりに空白を使う
set expandtab
" インデントを shiftwidth の値の倍数に丸める
set shiftround

" }}}

" === Tags {{{2

" 解説
"  http://archiva.jp/web/tool/vim_ctags.html#
"  ctagsはMacデフォルトのものは機能不足のため使用しない
"  Homebrewでインストールしたものか、MacVim-Kaoriya付属の物を使用する
"
" 使い方
"  $ ctags *.c
"   カレントディレクトリの*.cファイルからタグファイルを生成
"
"  $ ctags -f ~/.tags -R /home/xxx/
"   「/home/www/」以下の全てのファイルから、「~/.tags」にタグファイルを生成
"   -f 生成ファイルを指定
"   -R 解析対象ディレクトリを指定
"
"  :set tags=~/.tags,/home/user/commontags
"   使用するタグファイルを指定。「,」で複数指定可能
"   .vimrcに記述しておけば、「vim -t tag」で起動時にタグまでジャンプできる
"
" キーバインド
"  C-]     カーソル位置の単語をタグとみなしてジャンプ。
"  C-t     直前のタグに戻る。
"  g C-]   複数候補がある場合に選択→ジャンプ。
"  C-w }   カーソル位置の単語の定義を、プレビューウィンドウで開く。
"  C-w C-z プレビューウィンドウを閉じる。(:pcと同じ)
"
" その他
"  :tselect  現在のタグの一覧を表示
"  :tfirst （タグが重複している場合）最初のタグへ
"  :tn （タグが重複している場合）次のタグへ
"  :tp （タグが重複している場合）前のタグへ
"  :tlast  （タグが重複している場合） 最後のタグへ
"  :tags 移動経路を確認
"  :tag  タグリストの前方にジャンプ。(:3tagなども可)
"  :tag [タグ名] 指定したタグにジャンプ。(:taと同じ)
"  :ptag [タグ名]  [タグ名]の定義をプレビューウィンドウで開く。
"

if has('autochdir')
  " 編集しているファイルのディレクトリに自動で移動
  set autochdir
  set tags=tags;
else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
  " Don't search tags file in current directory. And search upward.
  set tags& tags-=tags tags+=./tags;
endif

if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

set wildoptions=tagfile
set showfulltag

" }}}

" === Misc {{{2

"### autodate.vim
"let autodate_format="%Y/%m/%d %H:%M:%S"
let autodate_format = '%d %3m %Y'
let autodate_keyword_pre = 'Last \%(Change\|Modified\) *:'


"### KeyMap for Mac
if s:is_mac
  " 編集中のファイルをブラウザ(Chrome)で開く(Mac Only)
  "  %:p 現在編集中のファイルの絶対パス
  command! OB :silent call s:open_browser()
  function! s:open_browser()
    try
      execute '!open -a Google\ Chrome %:p'
    finally
      " 画面を消去して再描画
      execute 'redraw!'
    endtry
  endfunction

  " MarkdownをMarked.appで開く
  :nnoremap <leader>om :silent !open -a Marked.app '%:p'<cr>:redraw!<cr>

  " Dash.appで検索  language:word
  function! s:dash(...)
    let ft = &filetype
    if &filetype == 'python'
      let ft = ft.'2'
    endif
    let ft = ft.':'
    let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
    call system(printf("open dash://'%s'", word))
  endfunction
  command! -nargs=* Dash call <SID>dash(<f-args>)
endif


"### Quickfix自動Open/Close
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep,Sgrep call s:auto_qf_open()
" QuickFixを自動で開く
function! s:auto_qf_open()
  if len(getqflist()) != 0
    execute 'HierUpdate'
    execute 'QuickfixStatusEnable'
    execute 'QuickfixsignsEnable'
    execute 'cwindow'
    execute 'redraw!'
  endif
endfunction


"### 不要なWindow自動で閉じる
autocmd MyAutoCmd WinEnter * call s:auto_qf_close()
function! s:auto_qf_close()
  for winnr in range(1, winnr('$'))
    let buftype = getwinvar(winnr, '&buftype')
    let ft = getwinvar(winnr, '&filetype')
    if buftype ==# 'quickfix' || ft ==# 'nerdtree' || ft ==# 'help'
          \ || ft ==# 'vimfiler' || ft ==# 'quickrun'
    " exists('b:NERDTreeType') && b:NERDTreeType == 'primary'
    else
      return
    endif
  endfor
  quitall
endfunction


"### Default Skeleton File
augroup SkeletonAu
  autocmd!
  autocmd BufNewFile *.html 0r $HOME/.vim/my_templates/skel.html
  autocmd BufNewFile *.sh 0r $HOME/.vim/my_templates/skel.sh
  autocmd BufNewFile *.py 0r $HOME/.vim/my_templates/skel.py
  autocmd BufNewFile *.user.js 0r $HOME/.vim/my_templates/skel.user.js
augroup END


"### Reload .vimrc and .gvimrc automatically.
let g:enable_reload_vimrc = 0
if !has('gui_running') && !s:is_windows
  autocmd MyAutoCmd BufWritePost .vimrc* nested
        \ if g:enable_reload_vimrc |
        \ source $MYVIMRC |
        \ call s:set_syntax_of_user_defined_commands() |
        \ echo "source $MYVIMRC"
else
  autocmd MyAutoCmd BufWritePost .vimrc*
        \ if g:enable_reload_vimrc |
        \ source $MYVIMRC |
        \ call s:set_syntax_of_user_defined_commands() |
        \ if has('gui_running') | source $MYGVIMRC | echo "source $MYVIMRC"
  autocmd MyAutoCmd BufWritePost .gvimrc*
        \ if g:enable_reload_vimrc |
        \ if has('gui_running') | source $MYGVIMRC | echo "source $MYGVIMRC"
endif

" Auto reload VimScript.
autocmd MyAutoCmd BufWritePost,FileWritePost *.vim
      \ if g:enable_reload_vimrc && &autoread
      \ | source <afile> | echo 'source ' . bufname('%') | endif


"### Syntax highlight for user commands.
augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands()
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction


"### 自動的にコメント文字を挿入させない
autocmd MyAutoCmd FileType *
      \ setl formatoptions& formatoptions-=ro formatoptions+=mM


if exists('$TMUX') && !has('gui_running')
  autocmd MyAutoCmd BufEnter * call <SID>set_vim_cwd_to_tmux()
  autocmd MyAutoCmd VimLeave * call <SID>del_vim_cwd_from_tmux()
endif

function! s:set_vim_cwd_to_tmux()
  if !exists('$TMUX') || has('gui_running')
    return
  endif

  let pain_id = system('tmux display -p "#D" | tr -d "%" | tr -d $"\n"')
  call system('tmux setenv ' . "TMUX_VIM_CWD_" . pain_id . ' ' . getcwd())

  let bt = &buftype
  let ft = &filetype
  " let bn = bufname('%')
  if bt ==# 'nofile'
        \ || ft ==# 'gitcommit' || ft ==# 'git-status' || ft ==# 'git-log'
        \ || ft ==# 'qf' || ft ==# 'gitcommit' || ft ==# 'quickrun'
        \ || ft ==# 'qfreplace' || ft ==# 'ref' || ft ==# 'vcs-commit'
        \ || ft ==# 'vcs-status'
    let pwd = getcwd()
  else
    let pwd = expand('%:p:h')
  endif

  let var_name = system('tmux display -p "TMUXPWD_#D" | tr -d "%" | tr -d $"\n"')
  call system('tmux setenv ' . var_name . ' ' . shellescape(pwd))
endfunction

function! s:del_vim_cwd_from_tmux()
  if !exists('$TMUX')
    return
  endif
  let var_name = system('tmux display -p "TMUX_VIM_CWD_#D" | tr -d "%" | tr -d $"\n"')
  call system('tmux setenv -u ' . var_name)
endfunction

" }}}

" }}}


" === Mappings ====================================================={{{1

" === Search & Yank & Replace {{{2

"### Search with very magic.
" http://deris.hatenablog.jp/entry/2013/05/15/024932
nnoremap / /\v

"### 選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>


"### カーソル位置の単語をyankする
nnoremap vy viwy
" カーソル位置の単語をyankした文字に置き換える
nnoremap vp viwpviwy


"### Visualモードで選択範囲をレジスタの内容に置き換える
vnoremap zy "zy
vnoremap zp "zp


"### 縦ペースト
vnoremap <C-p> I<C-r>"<ESC><ESC>


" y9で行末までヤンク
nmap y9 y$
" y0で行頭までヤンク
nmap y0 y^


"### カーソル下の単語で置換
" 1.置換後文字列をヤンク(あれば)  2.置換元単語にカーソルを移動
" 3.s*  4.置換後文字列を編集して
" (ヤンクした文字列を貼り付け : <C-r>")
" (クリップボードから貼り付け : <C-r>+)
nnoremap <expr> <C-s> ':%s/' . expand('<cword>') . '/<C-r>"/gc<Left><Left>'
"nnoremap <expr> ss* ':%s/\<' . expand('<cword>') . '\>/<C-r>"/g'


"### 選択した文字列で置換
" 1.置換後文字列をヤンク(あれば)  2.ビジュアルモードで置換元文字列を選択
" 3.s*  4.置換後文字列を編集して実行
" 5./g 入力後に実行
vnoremap <C-s> "vy:%s/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR>/<C-r>+/gc<Left><Left>
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>


"### 選択範囲のみ置換
" 1.置換元文字列をヤンク  2.置換範囲を選択
" 3.sv  4.置換後文字列を手入力
vnoremap sv "vy:%s/\%V<C-r>+//gc<Left><Left><Left><Left>

" ### 選択範囲を囲む
vnoremap { "zdi<C-V>{<C-R>z}<ESC>
vnoremap } "zdi<C-V>{<C-R>z}<ESC>
vnoremap [ "zdi<C-V>[<C-R>z]<ESC>
vnoremap ] "zdi<C-V>[<C-R>z]<ESC>
vnoremap ( "zdi<C-V>(<C-R>z)<ESC>
vnoremap ) "zdi<C-V>(<C-R>z)<ESC>
vnoremap " "zdi<C-V>"<C-R>z<C-V>"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" #### Ctrl-v で insert/command モードで貼り付け
inoremap <C-v> <ESC>"*pa
cnoremap <C-v> <C-r>+
" }}}

" === Move {{{2

"### カーソルを表示行で移動する
" 論理行移動は<C-n>,<C-p>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> j
nnoremap <Up>   k

noremap H b
" noremap L w
noremap L e
noremap J }
noremap K {
noremap gJ J


"### insert mode でjjでesc
inoremap jj <Esc>


"### 0, 9で行頭、行末へ
nmap 1 0
nmap 0 ^
nmap 9 $

" 前回編集箇所へ
noremap g<CR> g;


"### 検索結果に移動したとき、その位置を画面の中央へ
nnoremap n nzz
nnoremap N Nzz
"nnoremap * *zz
nmap * *N
nnoremap # #N
nnoremap g* g*N
nnoremap g# g#N


"### Insertモードのキーバインドをemacs風に
" 行頭/行末へ移動
inoremap  <C-a> <HOME>
inoremap  <C-e> <END>
" C-hjklで移動 - Mac:KeyRemap4MacBookで対応
if ! has('mac')
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>
endif
" Backspace
"  C-q/C-sは端末側で使用されているため stty -ixoff -ixon を実行する必要がある
"  (.bashrcや.zshrcなどに設定する)
"  http://d.hatena.ne.jp/ksmemo/20110214/p1
"  http://www.akamoz.jp/you/uni/shellscript.htm
inoremap  <C-q> <ESC>xi


"### Cmdモードのキーバインドをemacs風に
cnoremap  <C-a> <HOME>
cnoremap  <C-e> <END>
cnoremap  <C-q> <BS>


"### バッファ移動
" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>
" F4でバッファを削除する
" map <F4> <ESC>:bnext \| bdelete # \| if tabpagenr('$') != 1 \| tabclose \| endif<CR>
map <silent> <F4> <ESC>:call <SID>delete_buf()<CR>
function! s:delete_buf()
  bnext
  if bufnr('%') == bufnr('#')
    bdelete #
  else
    echo 'Last buffer!'
  endif
  if tabpagenr('$') != 1
    tabclose
  endif
endfunction

nnoremap B :ls<CR>:b


"### Window size を怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-
"nnoremap <S-Left>  <C-w><<CR>
"nnoremap <S-Right> <C-w>><CR>
"nnoremap <S-Up>    <C-w>-<CR>
"nnoremap <S-Down>  <C-w>+<CR>


"### 最後に編集された位置に移動
nnoremap gb '[
nnoremap gp ']


"### 対応する括弧に移動
nnoremap ( %
nnoremap ) %


"### 最後に変更されたテキストを選択する
nnoremap gc :<C-u>normal! `[v`]<CR>
vnoremap gc <C-u>normal gc<Enter>
onoremap gc <C-u>normal gc<Enter>


" Quickfix 前へ
nnoremap <buffer> [q :cprevious<CR>
" Quickfix 次へ
nnoremap <buffer> ]q :cnext<CR>


" }}}

" === Edit {{{2

"### normalモードでも改行入力可能
" QuickFixでEnterでジャンプができなくなるので不可
"noremap <CR> i<CR><ESC>


"### ビジュアルモードで連続インデント
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" <TAB>, <S-TAB>: indent, unindent
xnoremap <TAB> >
xnoremap <S-TAB> <


"### コンマの後に自動的にスペースを挿入
"inoremap , ,<Space>

"### Insert mode中で単語単位/行単位の削除をアンドゥ可能にする
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>


"### 保存時に行末の空白を除去する
autocmd MyAutoCmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd MyAutoCmd  BufWritePre * :%s/\t/  /ge


"### 日時の自動入力 (挿入モードで入力)
inoremap <expr> <Leader>df strftime('%Y/%m/%d %H:%M:%S')
inoremap <expr> <Leader>dd strftime('%Y/%m/%d')
inoremap <expr> <Leader>dt strftime('%H:%M:%S')


"### <leader>j でJSONをformat
" http://wozozo.hatenablog.com/entry/2012/02/08/121504
map <Leader>j !python -m json.tool<CR>


"### XMLの閉タグを自動挿入
autocmd MyAutoCmd  Filetype xml inoremap <buffer> </ </<C-x><C-o>


"### 線を引く (挿入モードで入力)
inoremap <expr> <Leader>r* repeat('*', 79 - col('.'))
inoremap <expr> <Leader>r# repeat('#', 79 - col('.'))
inoremap <expr> <Leader>r+ repeat('+', 79 - col('.'))
inoremap <expr> <Leader>r- repeat('-', 79 - col('.'))
inoremap <expr> <Leader>r= repeat('=', 79 - col('.'))

" ### 自動閉じ括弧入力
function! s:auto_close_bracket()
  " inoremap <silent> <buffer> { {}<Left>
  " inoremap <silent> <buffer> [ []<Left>
  " inoremap <silent> <buffer> ( ()<Left>
  " inoremap <silent> <buffer> " ""<Left>
  " inoremap <silent> <buffer> ' ''<Left>
  inoremap <silent> <buffer> () ()<Left>
  inoremap <silent> <buffer> [] []<Left>
  inoremap <silent> <buffer> {} {}<Left>
  inoremap <silent> <buffer> "" ""<Left>
  inoremap <silent> <buffer> '' ''<Left>
  inoremap <silent> <buffer> <> <><Left>
endfunction
autocmd MyAutoCmd FileType python,coffee,javascript,html,vim,ruby,sh,zsh
      \ call s:auto_close_bracket()

" }}}

" === Misc {{{2

"### Escの2回押し
"   検索ハイライト消去
"   vim-hierのハイライト消去
nmap <silent><ESC><ESC> :<C-u>nohlsearch<CR>:HierClear<CR>:redraw!<CR><ESC>


"### vimrc
" 編集
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
" リロード
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>


"### 強制全保存終了を無効化。
nnoremap ZZ <Nop>


"### 保存
" nnoremap <CR> :<C-u>w<CR>


"### マーク
" マークジャンプ(前)のキーバインド削除
" screen/tmuxのエスケープキーと重複しているため
nnoremap <C-o>  <Nop>
" マーク一覧表示
nnoremap <Space>m  :<C-u>marks<CR>


"### レジスタ
" 一覧
nnoremap <Space>r  :<C-u>registers<CR>


"### ヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>


"### Ex-modeで<C-p><C-n>ヒストリ補完
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>


"### T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>


"### w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %


"### q/ESCで Quickfix, help, git windowを閉じる
autocmd MyAutoCmd FileType help,git-status,git-log,qf,
      \gitcommit,quickrun,qfreplace,ref,vcs-commit,vcs-status
      \ nnoremap <buffer><silent> q :<C-u>call <SID>smart_close()<CR>
autocmd MyAutoCmd FileType help,qf,quickrun,ref
      \ nnoremap <buffer><silent> <ESC> :<C-u>call <SID>smart_close()<CR>

autocmd MyAutoCmd FileType * if (&readonly || !&modifiable)
      \ && &ft !=# 'vimfiler' && &ft !=# 'unite'
      \ && !hasmapto('q', 'n')
      \ | nnoremap <buffer><silent> q :<C-u>call <SID>smart_close()<CR>| endif
autocmd MyAutoCmd FileType * if (&readonly || !&modifiable) && !hasmapto('<ESC>', 'n')
      \ | nnoremap <buffer><silent> <ESC> :<C-u>call <SID>smart_close()<CR>| endif

" nnoremap <silent> q :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> q <NOP>
nnoremap Q q

function! s:smart_close()
  if winnr('$') != 1
    close
  elseif &readonly || !&modifiable
    quitall
  endif
endfunction

"### Quickfix
" QuickFixの結果をクリア
"nnoremap <silent> <Leader>qc :cexpr ""<CR>

" QuickFixウィンドウの表示をtoggle
function! s:toggle_qf_window()
  for bufnr in range(1,  winnr('$'))
    if getwinvar(bufnr,  '&buftype') ==# 'quickfix'
      execute 'ccl'
      return
    endif
  endfor
  execute 'botright cw'
endfunction
nnoremap <silent> cw :call <SID>toggle_qf_window()<CR>


"### テキストの折り返し表示のtoggle
nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>


"### Folding
" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press l on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
" 移動 : zj / zk
" 開く : zo or za (zO or zA)
" 閉じる : zc (zC)
" 開く(全て) : zm (zM)
" 閉じる(全て) : zr (zR)
" 作成 : zf
" 削除 : zd
noremap zu :<C-u>Unite outline:foldings<CR>
" noremap zz zc
nnoremap <silent> zz :<C-u>call <SID>smart_foldcloser()<CR>
function! s:smart_foldcloser()
  if foldlevel('.') == 0
    norm! zM
    return
  endif

  let foldc_lnum = foldclosed('.')
  norm! zc
  if foldc_lnum == -1
    return
  endif

  if foldclosed('.') != foldc_lnum
    return
  endif
  norm! zM
endfunction


"### Tab pages (Vim 7)
nnoremap <C-t>  <Nop>
nnoremap <silent> <C-t>n  :<C-u>tabnew<CR>
nnoremap <silent> <C-t>c  :<C-u>tabclose<CR>
nnoremap <silent> <C-t>o  :<C-u>tabonly<CR>
nnoremap <silent> <C-t>j  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <silent> <C-t>l  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <silent> <C-t>k  gT
nnoremap <silent> <C-t>h  gT
command! -nargs=* -complete=file E tabnew <args>

nunmap <Tab><Tab>
nnoremap <silent> <Tab> :call <SID>NextWindowOrTab()<CR>
nnoremap <silent> <S-Tab> :call <SID>PreviousWindowOrTab()<CR>

function! s:NextWindow()
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction

function! s:NextWindowOrTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    call s:split_nicely()
  elseif winnr() < winnr("$")
    wincmd w
  else
    tabnext
    1wincmd w
  endif
endfunction

function! s:PreviousWindowOrTab()
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr("$") . "wincmd w"
  endif
endfunction

command! SplitNicely call s:split_nicely()
function! s:split_nicely()
  " Split nicely.
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction


"### Tags
"tags-and-searchesを使い易くする
nnoremap t  <Nop>
"「飛ぶ」
nnoremap tt  <C-]>
"「進む」
nnoremap tj  :<C-u>tag<CR>
"「戻る」
nnoremap tk  :<C-u>pop<CR>
"履歴一覧
nnoremap tl  :<C-u>tags<CR>


"### git-diff-aware version of gf commands.
" http://labs.timedia.co.jp/2011/04/git-diff-aware-gf-commands-for-vim.html
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction


" Increment.
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)    :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num)
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction


"### 補完中にESCで補完キャンセル
"inoremap <silent><expr><ESC> pumvisible() ? neocomplcache#cancel_popup()."<ESC>" : "<ESC>"


"## クリップボード
" xではクリップボードに入れない
" http://vivi.dyndns.org/SPR/SPR.phtml?project=ViVi210xx&sprID=40
" YankRingがあるとこの設定はできない
" ClipMenuの除外対象APL+YankRingの最少文字数で対応
"nnoremap <silent>x "_x

" 挿入モードでクリップボード貼り付け
"imap <C-k>  <ESC>"*pa

" Visual Mode のカラーテスト
" let g:highlight_test_set = {}
" let g:highlight_test_group = 'Comment'
" nnoremap <C-m> :call <SID>change_color('+')<cr>
" vnoremap <C-m> <ESC>:call <SID>change_color('+')<cr>
" nnoremap <C-q> :call <SID>change_color('-')<cr>
" vnoremap <C-q> <ESC>:call <SID>change_color('-')<cr>
" function! s:change_color(flag)
"   let val = get(g:highlight_test_set, g:highlight_test_group, -1)
"   if a:flag == '+'
"     let val = val + 1
"   else
"     let val = val - 1
"   endif
"   if val < 0
"     let val = 0
"   elseif val > 255
"     let val = 255
"   endif
"   let g:highlight_test_set[g:highlight_test_group] = val
"   execute 'hi' g:highlight_test_group 'ctermfg=' . val
"   " -15
"   " normal! VG
"   echo g:highlight_test_group . '=' . val
" endfunction

" }}}

" }}}


" === Commands ====================================================={{{1

"### Edit vimrc, Reload vimrc
command! Ev edit $MYVIMRC
command! Sv source $MYVIMRC


"### ペーストモード
command! Pt setlocal paste! | setlocal paste?


"### バッファ削除
command! Bw :bnext \| bdelete #


"### Diff
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap


"### Grep
" grepコマンドを改良: Sgrep
"  silent コマンド実行時に表示されるメッセージを抑制
"  grep! 検索後に自動でジャンプしない
command! -nargs=+ Sgrep execute 'silent grep! <args>'

" 開いているバッファ内を検索
command! -nargs=1 Bgrep execute 'silent vimgrepadd /<args>/ %'

" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
" nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>


"### vimのカレントディレクトリを現在編集中のファイルのディレクトリに変更
" http://vim-users.jp/2009/09/hack69/
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction


"### :HighlightWith {filetype} ['a 'b]  XXX: Don't work in some case.
command! -nargs=+ -range=% HighlightWith <line1>,<line2>call s:highlight_with(<q-args>)
function! s:highlight_with(args) range
  if a:firstline == 1 && a:lastline == line('$')
    return
  endif
  let c = get(b:, 'highlight_count', 0)
  let ft = matchstr(a:args, '^\w\+')
  if globpath(&rtp, 'syntax/' . ft . '.vim') == ''
    return
  endif
  unlet! b:current_syntax
  let save_isk= &l:isk  " For scheme.
  execute printf('syntax include @highlightWith%d syntax/%s.vim',
        \              c, ft)
  let &l:isk= save_isk
  execute printf('syntax region highlightWith%d start=/\%%%dl/ end=/\%%%dl$/ '
        \            . 'contains=@highlightWith%d',
        \             c, a:firstline, a:lastline, c)
  let b:highlight_count = c + 1
endfunction


"### ファイル名変更
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))


"### 文字コードを指定して強制的にファイルを開く
"  -bang : !付きで実行可能
" UTF-8
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
" iso-2022-jp
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
" Cp932S
command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
" EUC-jp
command! -bang -bar -complete=file -nargs=? Euc edit<bang> ++enc=euc-jp <args>
" UTF-16
command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
" UTF-16BE

command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>


" fileencoding 変更
" (保存するとファイルが壊れる可能性あり)
command! WUtf8 setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932 setlocal fenc=cp932
command! WEuc setlocal fenc=euc-jp
command! WUtf16 setlocal fenc=ucs-2le
command! WUtf16be setlocal fenc=ucs-2
command! WJis  WIso2022jp
command! WSjis  WCp932
command! WUnicode WUtf16

" fileformat 変更
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
command! -bang -complete=file -nargs=? WMac
      \ write<bang> ++fileformat=mac <args> | edit <args>

"### vimコマンドの結果をキャプチャ
" http://webtech-walker.com/archive/2010/04/27173007.html
" https://github.com/edsono/vim-viewoutput/blob/master/plugin/viewoutput.vim
command!
  \ -nargs=1
  \ -complete=command
  \ Capture
  \ call Capture(<f-args>)

function! Capture(cmd)
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal filetype=vim
  silent file `=bufname`
  silent put =result
  1,2delete _
endfunction


"### vim 用のセパレータを引く
function! s:separator(width, sep, ...)
  let register = v:register != '' ? v:register : '"'
  let title = eval('@'.register)
  if len(title) == 0 || len(title) > 40 || len(getline(line('.'))) > 40
    return
  endif
  let title = ' '.title.' '
  let len_title = strlen(substitute(title, ".", "x", "g"))
  let start = a:0 >= 1 ? a:1 : repeat(a:sep, 3)
  let start = '" '.start
  let end = a:0 >= 2 ? a:2 : '{{{' " }}}
  let repeat_sep = a:width - len(start) - len_title - len(end)
  let line = start.title.repeat(a:sep, repeat_sep).end
  execute 'normal! 0d$'
  execute 'normal! i'.line
endfunction
command! Sep :silent call s:separator(78, '=')

command! -nargs=1 Line :silent :execute 'normal! i'.(repeat(<f-args>, 79 - col('.')))


"### echo-sd
" https://gist.github.com/yoshikaw/5693185
if executable('echo-sd')
  command! -nargs=* -range -bang EchoSd call s:echo_sd(<bang>0, <q-args>)
  function! s:echo_sd(bang, ...)
    let tmp = @@
    silent normal gvy
    let target = a:bang ? "'<,'>" : ''
    let selected = map(split(substitute(@@, '[\t]\+', '', 'g'), '[\n]'), 'shellescape(v:val, 1)')
    execute target . "!echo-sd" join(a:000, ' ') join(selected, ' ')
    let @@ = tmp
  endfunction
endif


"### Get hilight group.
" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()


"### Clear undo history.
function! s:clear_undo() abort
  let old_undolevels = &undolevels
  setlocal undolevels=-1
  execute "normal! a \<BS>\<Esc>"
  let &l:undolevels = old_undolevels
  echom strftime('[%Y-%m-%d %H:%M:%S]').' Clear undo!'
endfunction
command! -bar ClearUndo  call <SID>clear_undo()
command! -bar -bang -nargs=? -complete=file W call <SID>clear_undo() | write<bang> <args>
" }}}


" === autocmd ======================================================{{{1

" Set filetype.
augroup MyAutoCmdEx
  autocmd!
  " typescript
  autocmd BufRead,BufNewFile *.ts setl filetype=typescript
  " less
  autocmd BufRead,BufNewFile *.less setl filetype=less
  " applescript
  autocmd BufRead,BufNewFile *.applescript,*.scpt setl filetype=applescript
  autocmd FileType applescript inoremap <buffer> <S-CR>  ￢<CR>
  " markdown
  autocmd BufRead,BufNewFile *.md setl filetype=markdown

  " Rakefile
  autocmd BufNewfile,BufRead Rakefile foldmethod=syntax foldnestmax=1


  autocmd FileType ref nnoremap <buffer> <TAB> <C-w>w

  " ファイル書き込み時に再度 filetype 判定
  autocmd BufWritePost *
    \ if &l:filetype ==# '' || exists('b:ftdetect')
    \ |   unlet! b:ftdetect
    \ |   filetype detect
    \ | endif

" Improved include pattern.
  autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/
  autocmd FileType php setlocal path+=/usr/local/share/pear
  autocmd FileType apache setlocal path+=./;/

  " Localize search options.
  " http://d.hatena.ne.jp/tyru/20140129/localize_search_options
  autocmd WinLeave *
        \     let b:vimrc_pattern = @/
        \   | let b:vimrc_hlsearch = &hlsearch
  autocmd WinEnter *
        \     let @/ = get(b:, 'vimrc_pattern', @/)
        \   | let &l:hlsearch = get(b:, 'vimrc_hlsearch', &l:hlsearch)


" Set sw/sts/ts.
" sw  : shiftwidth (インデント時に使用されるスペースの数)
" sts : softtabstop (0でないなら、タブを入力時、その数値分だけ半角スペースを挿入)
" ts  : tabstop (タブを画面で表示する際の幅)
" et  : expandtab (有効時、タブを半角スペースとして挿入)
" ml  : modeline
" tw  : textwidth
" modeline : モードラインを有効
" http://nanasi.jp/articles/howto/file/modeline.html
  autocmd!
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType csh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType gitcommit  setlocal sw=4 sts=4 ts=4 et tw=72
  autocmd FileType gitconfig  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType less       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType make       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=8 et tw=80
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType typescript setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et

  autocmd FileType qf,qfreplace,quickrun,git,diff,gitv,gitcommit
        \ setlocal nofoldenable nomodeline foldcolumn=0 foldlevel=0

  " インデント無効
  "autocmd FileType html :set indentexpr=
  "autocmd FileType xhtml :set indentexpr=
augroup END

" }}}


" === Functions =========================================================={{{1

function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction

function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction

function! s:strchars(str)
  return len(substitute(a:str, '.', 'x', 'g'))
endfunction

function! s:strwidthpart(str, width)
  if a:width <= 0
    return ''
  endif
  let ret = a:str
  let width = s:wcswidth(a:str)
  while width > a:width
    let char = matchstr(ret, '.$')
    let ret = ret[: -1 - len(char)]
    let width -= s:wcswidth(char)
  endwhile
  return ret
endfunction

function! s:strwidthpart_reverse(str, width)
  if a:width <= 0
    return ''
  endif
  let ret = a:str
  let width = s:wcswidth(a:str)
  while width > a:width
    let char = matchstr(ret, '^.')
    let ret = ret[len(char) :]
    let width -= s:wcswidth(char)
  endwhile
  return ret
endfunction

if v:version >= 703
  " Use builtin function.
  function! s:wcswidth(str)
    return strwidth(a:str)
  endfunction
else
  function! s:wcswidth(str)
    if a:str =~# '^[\x00-\x7f]*$'
      return strlen(a:str)
    end

    let mx_first = '^\(.\)'
    let str = a:str
    let width = 0
    while 1
      let ucs = char2nr(substitute(str, mx_first, '\1', ''))
      if ucs == 0
        break
      endif
      let width += s:_wcwidth(ucs)
      let str = substitute(str, mx_first, '', '')
    endwhile
    return width
  endfunction

  " UTF-8 only.
  function! s:_wcwidth(ucs)
    let ucs = a:ucs
    if (ucs >= 0x1100
          \  && (ucs <= 0x115f
          \  || ucs == 0x2329
          \  || ucs == 0x232a
          \  || (ucs >= 0x2e80 && ucs <= 0xa4cf
          \      && ucs != 0x303f)
          \  || (ucs >= 0xac00 && ucs <= 0xd7a3)
          \  || (ucs >= 0xf900 && ucs <= 0xfaff)
          \  || (ucs >= 0xfe30 && ucs <= 0xfe6f)
          \  || (ucs >= 0xff00 && ucs <= 0xff60)
          \  || (ucs >= 0xffe0 && ucs <= 0xffe6)
          \  || (ucs >= 0x20000 && ucs <= 0x2fffd)
          \  || (ucs >= 0x30000 && ucs <= 0x3fffd)
          \  ))
      return 2
    endif
    return 1
  endfunction
endif

" visualモードで最後に選択したテキストを%sで指定してコマンドを実行する
"http://deris.hatenablog.jp/entry/2013/07/05/023835
function! ExecuteWithSelectedText(command)
  if a:command !~? '%s'
    return
  endif
  let reg = '"'
  let [save_reg, save_type] = [getreg(reg), getregtype(reg)]
  normal! gvy
  let selectedText = @"
  call setreg(reg, save_reg, save_type)
  if selectedText == ''
    return
  endif
  execute printf(a:command, selectedText)
endfunction
" }}}


" === Startup {{{
" 自動実行 - Helper
function! s:auto_open_at_startup()
  VimFilerExplorer
  execute 'wincmd w'
  execute 'Startify'
  " execute 'edit $MYVIMRC'
  augroup AutoOpenAtStartup
    autocmd!
  augroup END
  augroup! AutoOpenAtStartup
endfunction

" http://saihoooooooo.hatenablog.com/entry/2013/05/24/130744
function! s:GetBufByte()
  let byte = line2byte(line('$') + 1)
  if byte == -1
    return 0
  else
    return byte - 1
  endif
endfunction

" 自動実行 - Main
if has('vim_starting')
      \ && len(expand('%:p')) == 0
      \ && !argc()
  augroup AutoOpenAtStartup
    autocmd!
    autocmd VimEnter * nested
          \ if @% == '' && s:GetBufByte() == 0
          \ | call <SID>auto_open_at_startup()
          \ | endif
  augroup END
else
  if exists(':IndentLinesReset')
    IndentLinesReset
  endif
endif

set secure

" }}}

" vim: fdm=marker:
