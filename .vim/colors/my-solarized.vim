"
"  Base colorscheme: molokai
"

"let g:solarized_termcolors=256   " default 16
"let g:solarized_contrast="high"  " default normal (high/low)
"let g:solarized_termtrans=1

set background=dark              " dark or light
colorscheme solarized            " カラースキーマ


"" カーソル行の色
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=0
" NomalModeとInsertModeでカーソル行の色を変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=0
augroup END


" indent-guides.vim
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif
