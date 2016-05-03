"
"  Base
"    colorscheme: w0ng/vim-hybrid
"

" === Setup {{{
set background=dark

colorscheme hybrid

augroup MyHybridAu
  autocmd!
augroup END
" }}}

" === Basic {{{
hi! Normal  ctermbg=black
hi! Normal  ctermbg=black
hi! Comment ctermfg=243

" Cursor.
hi! CursorLine               ctermbg=235                guibg=#282a2e
hi! CursorColumn             ctermbg=235                guibg=#282a2e
hi! CursorLineNr ctermfg=148 ctermbg=235  guifg=#afdf00 guibg=#262626 cterm=bold gui=bold
hi! LineNr       ctermfg=58  ctermbg=NONE guifg=#5f5f00 guibg=bg
hi! ColorColumn              ctermbg=232

" Folding.
hi Folded     ctermbg=NONE
hi FoldColumn ctermbg=NONE

autocmd MyHybridAu InsertLeave *
      \ hi! CursorLine   ctermbg=235 guibg=#282a2e |
      \ hi! CursorLineNr ctermbg=235 guibg=#282a2e
autocmd MyHybridAu InsertEnter *
      \ hi! CursorLine   ctermbg=18 guibg=#0000AF |
      \ hi! CursorLineNr ctermbg=18 guibg=#0000AF

" Diff.
hi! DiffAdd term=none cterm=none ctermfg=none ctermbg=22 guifg=fg guibg=#005f00
hi! DiffChange term=none cterm=none ctermfg=none ctermbg=52 guifg=fg guibg=#5f0000
hi! DiffDelete term=none cterm=none ctermfg=none ctermbg=88 guifg=fg guibg=#870000
hi! DiffText term=none cterm=none ctermfg=none ctermbg=160 guifg=fg guibg=#df0000
hi! DiffFile term=none cterm=none ctermfg=47 ctermbg=none guifg=#00ff5f guibg=bg
hi! DiffNewFile term=none cterm=none ctermfg=199 ctermbg=none guifg=#ff00af guibg=bg
hi! default link DiffRemoved DiffDelete
hi! DiffLine term=none cterm=none ctermfg=129 ctermbg=none guifg=#af00ff guibg=bg
hi! default link DiffAdded DiffAdd

hi! default link FullSpace Error
hi! Todo cterm=reverse ctermfg=185 ctermbg=16 gui=reverse guifg=#dfdf5f guibg=#000000
call matchadd('Todo', '\<\([tT]odo\|TODO\)\>', -1)
call matchadd('FullSpace', '　', -1)
" }}}

" === Plugins {{{
" indent-guides.vim
autocmd MyHybridAu VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#262626 ctermbg=12
autocmd MyHybridAu VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=239

" vim-hier.
hi! qf_error_ucurl   cterm=undercurl guisp=red
hi! qf_warning_ucurl cterm=undercurl guisp=blue

" Showmarks.
hi! ShowMarksHLl ctermfg=blue guifg=blue ctermbg=black       guibg=black
hi! ShowMarksHLu ctermfg=blue guifg=blue ctermbg=lightyellow guibg=black
hi! ShowMarksHLo ctermfg=blue guifg=blue ctermbg=black       guibg=black
hi! ShowMarksHLm ctermfg=blue guifg=blue ctermbg=black       guibg=black cterm=bold gui=bold

" vimshell, vimfiler, unite.vim.
hi! default link Command Function
hi! default link GitCommand Constant
hi! default link Arguments Type
hi! default link PdfHtml Function
hi! default link Archive Special
hi! default link Image Type
hi! default link Multimedia SpecialComment
hi! default link System Comment
hi! default link Text Constant
hi! default link Link Constant
hi! default link Exe Statement
hi! default link Prompt Identifier
hi! default link Icon LineNr

hi! Time ctermbg=141 guibg=#af87ff
hi! Date ctermbg=140 guibg=#af87df
hi! default link DateToday Special
hi! default link DateWeek Identifier
hi! default link DateOld Comment
hi! default link Path Preproc
hi! default link Marked StorageClass
hi! default link Title Identifier
" }}}
