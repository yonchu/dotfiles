if exists('b:did_ftplugin_html')
  finish
endif
let b:did_ftplugin_html = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal includeexpr=substitute(v:fname,'^\\/','','')
setlocal path+=./;/

syntax sync minlines=500 maxlines=1000

let &cpo = s:save_cpo
