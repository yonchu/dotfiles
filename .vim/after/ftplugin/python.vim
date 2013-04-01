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
if exists('&colorcolumn')
  setl colorcolumn=80
endif
setl smartindent
setl cinwords=if,elif,else,for,while,try,except,finally,def,class

" Folding
setl foldmethod=indent
setl foldlevel=0
setl foldnestmax=1
" setl foldcolumn=1
