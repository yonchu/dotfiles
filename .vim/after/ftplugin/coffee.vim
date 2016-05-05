if exists('b:did_ftplugin_coffee')
  finish
endif
let b:did_ftplugin_coffee = 1

setl tabstop=2
setl softtabstop=2
setl shiftwidth=2
setl expandtab
setl smarttab
setl autoindent
setl smartindent
setl nocindent
setl cinwords=if,unless,else,while,until,do,for,switch,try,catch,finally,->,=>,class

" Folding.
setl foldmethod=indent
setl foldlevel=0
setl foldnestmax=1
