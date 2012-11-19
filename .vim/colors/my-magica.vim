"
"  Base colorscheme: magica
"

set background=dark              " dark or light
colorscheme magica               " カラースキーマ


" コメント
highlight Comment ctermfg=8

" colorcolumn
highlight ColorColumn ctermbg=232


"" カーソル行
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=235
" NomalModeとInsertModeでカーソル行の色を変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=235
augroup END


" indent-guides.vim
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=234
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=14
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif
