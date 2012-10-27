"
"  Base colorscheme: darkblue
"

colorscheme darkblue

"補完候補ポップアップメニューのカラーを設定
highlight Pmenu ctermbg=gray ctermfg=black
highlight PmenuSel ctermbg=red ctermfg=white
highlight PmenuSbar ctermbg=0 ctermfg=9


" コメント文の色変更
highlight Comment ctermfg=DarkCyan guifg=DarkCyan

" 行番号の色変更
highlight LineNr cterm=underline ctermfg=2 gui=underline

" 行番号左のサイン表示列の色
highlight SignColumn ctermfg=Cyan ctermbg=Black guifg=Cyan guibg=Black

" Foldingの色変更
"highlight Folded ctermfg=lightmagenta guifg=lightred
"highlight FoldColumn ctermfg=red guifg=red

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
