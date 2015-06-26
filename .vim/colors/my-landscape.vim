"
"  Base
"    vim colorscheme     : itchyny/landscape.vim
"    terminal colorcheme : aereal/magica-colors
"

" === Setup {{{
set background=dark

let g:landscape_highlight_url = 1
let g:landscape_highlight_todo = 1
let g:landscape_highlight_full_space = 1

colorscheme landscape

augroup MyLandscapeAu
  autocmd!
augroup END
" }}}


" Folded Color
highlight Folded     term=bold ctermfg=darkred ctermbg=233
highlight FoldColumn           ctermfg=white   ctermbg=233

" Syntax
if $ITERM_PROFILE =~ "Magica.*"
    highlight String ctermfg=209
    highlight Statement ctermfg=77
    highlight Type      ctermfg=177
    highlight PreProc    ctermfg=32
endif

" Cursor
if version >= 700
  highlight ColorColumn ctermbg=232
  autocmd MyLandscapeAu InsertLeave *
        \ highlight CursorLine   ctermbg=235 |
        \ highlight CursorLineNr ctermbg=235
  autocmd MyLandscapeAu InsertEnter *
        \ highlight CursorLine   ctermbg=18 |
        \ highlight CursorLineNr ctermbg=18
endif

" === Plugins {{{
" indent-guides.vim
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray  ctermbg=12
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=239

" vim-hier
highlight qf_error_ucurl   gui=undercurl guisp=red  ctermfg=none cterm=undercurl
highlight qf_warning_ucurl gui=undercurl guisp=blue ctermfg=none cterm=undercurl

" Showmarks
highlight ShowMarksHLl cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLu cterm=NONE ctermfg=blue ctermbg=lightyellow gui=NONE guifg=blue guibg=black
highlight ShowMarksHLo cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLm cterm=bold ctermfg=blue ctermbg=black       gui=bold guifg=blue guibg=black

" MiniBufExpl
highlight def link MBEChanged               MBENormal
highlight def link MBEVisibleChanged        MBEVisibleNormal
highlight def link MBEVisibleChangedActive  MBEVisibleActive
" }}}
