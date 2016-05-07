if exists('b:did_ftplugin_vim')
  finish
endif
let b:did_ftplugin_vim = 1

let s:save_cpo = &cpo
set cpo&vim

" undo_ftplugin.
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl modeline<'

" Indent.
setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

setlocal iskeyword+=:,#

" gf.
let &l:path = join(map(split(&runtimepath, ','), 'v:val."/autoload"'), ',')
setlocal suffixesadd=.vim
setlocal includeexpr=fnamemodify(substitute(v:fname,'#','/','g'),':h')

let &cpo = s:save_cpo
