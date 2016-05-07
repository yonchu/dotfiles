" http://d.hatena.ne.jp/cohama/20120417/1334679297
let g:Gitv_OpenHorizontal = 0

" http://d.hatena.ne.jp/cohama/20130517/1368806202
function! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

autocmd MyAutoCmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
  setlocal iskeyword+=/,-,.
  " Checkout the branch under the cursor.
  " Move to branch: r/R
  nnoremap <silent><buffer> C :<C-u>Git checkout <C-r><C-w><CR>

  nnoremap <buffer> <Space>rb :<C-u>Git rebase <C-r>=GitvGetCurrentHash()<CR><Space>
  nnoremap <buffer> <Space>R  :<C-u>Git revert <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>h  :<C-u>Git cherry-pick <C-r>=GitvGetCurrentHash()<CR><CR>
  nnoremap <buffer> <Space>rh :<C-u>Git reset --hard <C-r>=GitvGetCurrentHash()<CR>

  nnoremap <silent><buffer> T :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endfunction

function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction
