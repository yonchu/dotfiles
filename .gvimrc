"*******************************************************************************
"
" .gvimrc
"   GUI版vimの設定ファイル
"
"*******************************************************************************

" solarized settings
" let g:solarized_termcolors=256   "default value is 16
" let g:solarized_contrast="high"  "default value is normal
" syntax enable
" set background=dark              " dark or light
" colorscheme solarized            " カラースキーマ
" let g:solarized_termcolors=256   " 256色(solarizedスキーマ専用)

source ~/.vim/colors/my-hybrid.vim

" IM自動制御 (GUI専用)
" http://blogger.splhack.org/2011/01/macvim-kaoriya-20110111.html
set imdisableactivate            " ESCでIM自動OFF、入力モードでIM自動OFF
"set noimdisableactivate          " ESCでIM自動OFF、入力モードでIM自動ON
"set imdisable                    " IM自動制御OFF

set cmdheight=2                  " コマンドラインの高さ(GUI使用時)

if has('mac')
  set transparency=5
  set antialias

  " フォント(Regular Font)
  "set guifont=Osaka-Mono:h13
  "set guifont=Monaco:h13
  " set guifont=Ricty-RegularForPowerline:h16
  " set guifont=EnvyCodeRForPowerline:h16
  " set guifont=CodeM-RegularForPowerline:h14
  " set guifont=CodeMWide-RegularForPowerline:h14
  set guifont=CodeMExpanded-RegularForPowerline:h15

  " Non-ACSII Font
  "set guifontwide=Osaka-Mono:h13
  "set guifontwide=Ricty-Regular:h16

  set columns=120                  " width (列)
  set lines=45                     " line (行)
elseif has('linux')
  set guifont=Monaco\ 12
  set columns=100
  set lines=35
endif

" set spell

" カーソルラインのカラー設定 GUI版
" hi clear CursorLine
" hi CursorLine gui=underline

" カーソル点滅OFF
set guicursor=a:blinkon0

" マウス移動によるフォーカス切り替えを無効
set nomousefocus

" GUI版vimでもマウス選択機能有効
set guioptions+=a

set go-=T " no icons on the top of window
set go-=r " no right-hand scrollbar at any time
set go-=l " no left-hand scrollbar at any time
set go-=L " no left-hand scrollbar at any time
set go-=m " no gui menu (not for MacVim?)
set go+=c

" 起動スプラッシュOFF
set shortmess+=I


" http://vim-users.jp/2010/01/hack120/
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END
if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif


augroup dualvim
  autocmd!
  if has('mac')
    autocmd FocusGained * set transparency=5
    autocmd FocusLost * set transparency=50
  endif
augroup END
