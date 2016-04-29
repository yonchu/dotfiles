"
"  Base
"    colorscheme: altercation/vim-colors-solarized
"

"let g:solarized_termcolors=256   " default 16
"let g:solarized_contrast="high"  " default normal (high/low)
"let g:solarized_termtrans=1

set background=dark
colorscheme solarized

" CursorLine.
highlight CursorLine gui=underline ctermbg=0
augroup SorarizedColorAu
  autocmd!
  autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
  autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=0
augroup END

" Highlight full space.
highlight! ZenkakuSpace
      \ cterm=underline ctermfg=blue ctermbg=gray
      \ gui=underline   guifg=blue   guibg=gray
match ZenkakuSpace /　/

" vim-hier.
highlight qf_error_ucurl   gui=undercurl guisp=red  ctermfg=none cterm=undercurl
highlight qf_warning_ucurl gui=undercurl guisp=blue ctermfg=none cterm=undercurl

" Showmarks.
highlight ShowMarksHLl cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLu cterm=NONE ctermfg=blue ctermbg=lightyellow gui=NONE guifg=blue guibg=black
highlight ShowMarksHLo cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLm cterm=bold ctermfg=blue ctermbg=black       gui=bold guifg=blue guibg=black
