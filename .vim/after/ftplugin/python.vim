" バッファ再読み込み時の多重ロードを抑制
if exists("b:did_ftplugin_python")
  finish
endif
let b:did_ftplugin_python=1

" PEP 8 Indent rule
setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl nosmartindent
setl cindent
setl textwidth=80
setl colorcolumn=80
setl smartindent
setl cinwords=if,elif,else,for,while,try,except,finally,def,class

" Folding
setl foldmethod=indent
setl foldlevel=99

"------------------------------------
" Pydiction
"  Python用入力補完
"------------------------------------
Bundle 'Pydiction'
let g:pydiction_location = '~/.vim/pydiction/complete-dict'
