nnoremap <silent> <Plug>(open-browser-wwwsearch) :<C-u>call <SID>www_search()<CR>

function! s:www_search()
  let search_word = input('Please input search word: ', '',
        \ 'customlist,wwwsearch#cmd_Wwwsearch_complete')
  if search_word != ''
    execute 'OpenBrowserSearch' escape(search_word, '"')
  endif
endfunction

nnoremap <silent> <Plug>(open-browser-dein-repo) :<C-u>call <SID>open_browser_dein_repo()<CR>
function! s:open_browser_dein_repo() abort
  let sel = getline('.')
  if sel !~# ' *repo'
    return
  endif
  let sel = substitute(sel, ' *repo *= *\(.\+\)', '\1', '')
  let sel = substitute(sel, '"', '', 'g')
  let sel = substitute(sel, "'", '', 'g')
  if sel =~# '/'
    call openbrowser#open('https://github.com/'.sel)
  else
    call openbrowser#open('https://github.com/vim-scripts/'.sel)
  endif
endfunction
