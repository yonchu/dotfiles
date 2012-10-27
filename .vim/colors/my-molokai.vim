"
"  Base colorscheme: molokai
"

colorscheme molokai

highlight Normal   ctermbg=0
highlight Normal   ctermbg=0
highlight Comment  ctermfg=59
highlight NonText  ctermbg=0

highlight Pmenu     ctermbg=235
highlight PmenuSel  ctermbg=1
highlight PmenuSbar ctermbg=0

" colorcolumnの色指定
highlight ColorColumn guibg=#444444 ctermbg=233


" カーソル行の色
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=234
" NomalModeとInsertModeでカーソル行の色を変更
augroup InsertHook
  autocmd!
  autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
  autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=234
augroup END


" indent-guides.vim
if 'dark' == &background
  "hi IndentGuidesOdd  ctermbg=233
  "hi IndentGuidesEven ctermbg=233
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=233
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=233
else
  "hi IndentGuidesOdd  ctermbg=white
  "hi IndentGuidesEven ctermbg=lightgrey
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=233
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=233
endif
