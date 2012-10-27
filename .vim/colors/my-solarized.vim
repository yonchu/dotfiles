"
"  Base colorscheme: molokai
"

let g:solarized_termcolors=256   "default 16
let g:solarized_contrast="high"  "default normal (high/low)
let g:solarized_termtrans=1

set background=dark              " dark or light
colorscheme solarized            " カラースキーマ

" colorcolumnの色指定
highlight ColorColumn ctermbg=0

"" カーソル行の色
highlight clear CursorLine
highlight CursorLine gui=underline
highlight CursorLine ctermbg=8
" NomalModeとInsertModeでカーソル行の色を変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=8
augroup END


" indent-guides.vim
if 'dark' == &background
  "hi IndentGuidesOdd  ctermbg=233
  "hi IndentGuidesEven ctermbg=233
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
else
  "hi IndentGuidesOdd  ctermbg=white
  "hi IndentGuidesEven ctermbg=lightgrey
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif
