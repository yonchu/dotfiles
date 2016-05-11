if exists('b:did_ftplugin_help')
  finish
endif
let b:did_ftplugin_help = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

if !&modifiable || &readonly
  nnoremap <buffer> <CR> <C-]>
  nnoremap <buffer> <BS> <C-T>
  nnoremap <buffer> o    /'\l\{2,\}'<CR>
  nnoremap <buffer> O    ?'\l\{2,\}'<CR>
  nnoremap <buffer> s    /\|\zs\S\+\ze\|<CR>
  nnoremap <buffer> S    ?\|\zs\S\+\ze\|<CR>
endif

let &cpo = s:save_cpo
