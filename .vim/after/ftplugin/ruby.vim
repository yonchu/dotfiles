if exists('b:did_ftplugin_ruby')
  finish
endif
let b:did_ftplugin_ruby = 1

let s:save_cpo = &cpo
set cpo&vim

" Indent.
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

let &cpo = s:save_cpo
