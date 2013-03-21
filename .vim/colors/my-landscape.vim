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

let g:terminal_magica = get(g:, 'terminal_magica', 0)

colorscheme landscape

augroup MyLandscapeAu
  autocmd!
augroup END
" }}}

" Basic
highlight Normal ctermbg=Black

highlight Folded     term=bold ctermfg=DarkRed ctermbg=233
highlight FoldColumn           ctermfg=White   ctermbg=233

" Syntax
if g:terminal_magica
    highlight Statement ctermfg=112
    highlight Type      ctermfg=Magenta

    highlight Number     ctermfg=DarkBlue
    highlight PreProc    ctermfg=DarkGreen
    highlight Identifier ctermfg=DarkBlue

    highlight Operator  ctermfg=DarkYellow
    highlight Special   ctermfg=Yellow
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

" === Plugin {{{
" indent-guides.vim
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray  ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236

" vim-hier
highlight qf_error_ucurl   gui=undercurl guisp=red  ctermfg=none cterm=undercurl
highlight qf_warning_ucurl gui=undercurl guisp=blue ctermfg=none cterm=undercurl

" Showmarks
highlight ShowMarksHLl cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLu cterm=NONE ctermfg=blue ctermbg=lightyellow gui=NONE guifg=blue guibg=black
highlight ShowMarksHLo cterm=NONE ctermfg=blue ctermbg=black       gui=NONE guifg=blue guibg=black
highlight ShowMarksHLm cterm=bold ctermfg=blue ctermbg=black       gui=bold guifg=blue guibg=black
" }}}
