"
"  Base colorscheme: molokai
"

colorscheme molokai

" colorcolumnの色指定
highlight ColorColumn ctermbg=232


" カーソル行の色
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
  "hi IndentGuidesOdd  ctermbg=233
  "hi IndentGuidesEven ctermbg=233
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=232
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=232
else
  "hi IndentGuidesOdd  ctermbg=white
  "hi IndentGuidesEven ctermbg=lightgrey
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=232
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=232
endif
