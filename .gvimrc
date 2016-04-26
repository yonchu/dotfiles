" ============================================================================
"
"  .gvimrc
"
" ============================================================================
" Don't override colorscheme.
source ~/.vim/colors/my-hybrid.vim

" Font.
if has('mac')
  " Mac.
  " set transparency=5
  set antialias
  " Regular Font.
  set guifont=MyricaM\ Monospace\ for\ Powerline:h16
  " Non-ACSII Font
  "set guifontwide=
elseif has('win32') || has('win64')
  " Windows.
  " Number of pixel lines inserted between characters.
  set linespace=2
else
  " Linux.
  set guifont=Monaco\ 12
endif

" Enable mouse select.
set guioptions+=a
" Use console dialogs instead of popup dialogs.
set guioptions+=c
" Hide menus and toolbar.
set guioptions-=m
set guioptions-=Tt
" Hide scrollbar.
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Don't flick cursor.
set guicursor& guicursor=a:blinkon0

" IM control.
"   imdisableactivate    ESC:IM OFF / Insert:IM OFF
"   noimdisableactivate  ESC:IM OFF / Insert:IM ON
"   imdisable            IM auto control OFF
" http://blogger.splhack.org/2011/01/macvim-kaoriya-20110111.html
set imdisableactivate             " ESC:IM OFF / Insert:IM OFF

" Save and restore gvim window state.
" http://vim-users.jp/2010/01/hack120/
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindowAu
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

" Transparent window if gvim is inactive.
augroup AutoTransparentAu
  autocmd!
  if has('mac')
    autocmd FocusGained * set transparency=5
    autocmd FocusLost   * set transparency=50
  endif
augroup END

" Change cursor color when IM OFF.
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guifg=NONE guibg=DarkRed
endif
