" Quickfix settings
" http://d.hatena.ne.jp/thinca/20130708/1373210009

if exists("b:did_ftplugin_qf")
  finish
endif
let b:did_ftplugin_qf = 1

noremap <buffer> p  <CR>zz<C-w>p

nnoremap <silent> <buffer> dd :<C-u>call <SID>del_entry()<CR>
nnoremap <silent> <buffer> x  :<C-u>call <SID>del_entry()<CR>
vnoremap <silent> <buffer> d  :<C-u>call <SID>del_entry()<CR>
vnoremap <silent> <buffer> x  :<C-u>call <SID>del_entry()<CR>
nnoremap <silent> <buffer> u  :<C-u>call <SID>undo_entry()<CR>

if exists('*s:undo_entry')
  finish
endif

function! s:undo_entry()
  let history = get(w:, 'qf_history', [])
  if !empty(history)
    call setqflist(remove(history, -1), 'r')
  endif
endfunction

function! s:del_entry() range
  let qf = getqflist()
  let history = get(w:, 'qf_history', [])
  call add(history, copy(qf))
  let w:qf_history = history
  unlet! qf[a:firstline - 1 : a:lastline - 1]
  call setqflist(qf, 'r')
  execute a:firstline
endfunction
