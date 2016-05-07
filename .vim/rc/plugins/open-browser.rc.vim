nnoremap <Plug>(open-browser-wwwsearch) :<C-u>call <SID>www_search()<CR>

function! s:www_search()
  let search_word = input('Please input search word: ', '',
        \ 'customlist,wwwsearch#cmd_Wwwsearch_complete')
  if search_word != ''
    execute 'OpenBrowserSearch' escape(search_word, '"')
  endif
endfunction

call operator#user#define('open-neobundlepath', 'OpenNeoBundlePath')
function! OpenNeoBundlePath(motion_wise)
  if line("'[") != line("']")
    return
  endif
  let start = col("'[") - 1
  let end = col("']")
  let sel = strpart(getline('.'), start, end - start)
  let sel = substitute(sel, '^\%(github\|gh\|git@github\.com\):\(.\+\)', 'https://github.com/\1', '')
  let sel = substitute(sel, '^\%(bitbucket\|bb\):\(.\+\)', 'https://bitbucket.org/\1', '')
  let sel = substitute(sel, '^gist:\(.\+\)', 'https://gist.github.com/\1', '')
  let sel = substitute(sel, '^git://', 'https://', '')
  if sel =~ '^https\?://'
    call openbrowser#open(sel)
  elseif sel =~ '/'
    call openbrowser#open('https://github.com/'.sel)
  else
    call openbrowser#open('https://github.com/vim-scripts/'.sel)
  endif
endfunction
