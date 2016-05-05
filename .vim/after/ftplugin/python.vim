if exists('b:did_ftplugin_python')
  finish
endif
let b:did_ftplugin_python = 1

" PEP 8 Indent rule.
setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl expandtab
setl smarttab
setl autoindent
setl smartindent
setl nocindent
setl textwidth=80
setl cinwords=if,elif,else,for,while,try,except,finally,def,class

" Folding.
setl foldmethod=indent
setl foldlevel=0
setl foldnestmax=1

" http://d.hatena.ne.jp/heavenshell/20130917/1379428949
if get(g:, "jedi#popup_select_first", 0) == 0
  inoremap <buffer> . .<C-R>=jedi#complete_opened() ? "" : "\<lt>C-X>\<lt>C-O>\<lt>C-P>"<CR>
endif
