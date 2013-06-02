if exists("b:did_ftplugin_coffee")
  finish
endif
let b:did_ftplugin_coffee=1

setl tabstop=2
setl softtabstop=2
setl shiftwidth=2
setl expandtab
setl smarttab
setl expandtab
setl autoindent
setl smartindent
setl nocindent

" Folding
setl foldmethod=indent
setl foldlevel=0
setl foldnestmax=1
" setl foldcolumn=1

setl cinwords=if,unless,else,while,until,do,for,switch,try,catch,finally,->,=>,class
