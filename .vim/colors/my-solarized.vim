"
"  Base colorscheme: solarized
"

"let g:solarized_termcolors=256   " default 16
"let g:solarized_contrast="high"  " default normal (high/low)
"let g:solarized_termtrans=1

set background=dark              " dark or light
colorscheme solarized            " カラースキーマ


"" カーソル行の色
highlight clear CursorLine
highlight CursorLine gui=underline ctermbg=0
" NomalModeとInsertModeでカーソル行の色を変更
augroup SorarizedColorAu
  autocmd!
  autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
  autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=0
augroup END

" 全角スペースの表示：ハイライト
highlight ZenkakuSpace
      \ cterm=underline ctermfg=blue ctermbg=gray
      \ gui=underline   guifg=blue   guibg=gray
match ZenkakuSpace /　/

" indent-guides.vim
if 'dark' == &background
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
else
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
endif

" vim-hier
highlight qf_error_ucurl gui=undercurl guisp=red ctermfg=none cterm=undercurl
highlight qf_warning_ucurl gui=undercurl guisp=blue ctermfg=none cterm=undercurl

" Showmarks
highlight ShowMarksHLl cterm=NONE ctermfg=blue ctermbg=black gui=NONE guifg=blue guibg=black
highlight ShowMarksHLu cterm=NONE ctermfg=blue ctermbg=lightyellow gui=NONE guifg=blue guibg=black
highlight ShowMarksHLo cterm=NONE ctermfg=blue ctermbg=black gui=NONE guifg=blue guibg=black
highlight ShowMarksHLm cterm=bold ctermfg=blue ctermbg=black gui=NONE gui=bold guifg=blue guibg=black
