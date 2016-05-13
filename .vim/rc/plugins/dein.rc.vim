" === Introduction {{{
"
" https://github.com/Shougo/dein.vim
"
" Install: call dein#check_install() | call dein#install()
" Update:  call dein#check_update()  | call dein#update()
" Clean:   call call map(dein#check_clean(), "delete(v:val, 'rf')")
"
" Directory:
"   dein root: /.cache/dein
"   dein repo: /.cache/dein/repos/github.com/Shougo/dein.vim
" Plugin List:
"   default : /.vim/rc/dein.toml
"   lazy    : /.vim/rc/deinlazy.toml
"   ftplugin: /.vim/rc/deinft.toml
" Plugin Detail Settings:
"   /.vim/rc/plugins/*
" ======================================================================== }}}

" === Initialization {{{
let s:dein_dir = expand('$CACHE/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Load dein.
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    echoerr '[ERROR] Stop reading .vimrc: dein.vim not installed.'
    echoerr '[ERROR] Please run the following commands:'
    echoerr '$ mkdir -p ' . s:dein_repo_dir
    echoerr '$ git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
    " execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    finish
  endif
  " Set runtimepath.
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_repo_dir, ':p'), '/$', '', '')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [expand('<sfile>')]
        \ + split(glob('~/.vim/rc/*.toml'), '\n'))
  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy' : 1})
  call dein#load_toml('~/.vim/rc/deinft.toml')
  call dein#end()
  call dein#save_state()
  if has('vim_starting') && !has('gui_running') && expand('%:t') ==# '.vimrc'
    if dein#check_install()
      call dein#install()
    endif
  endif
endif
" Call manually the 'hook_post_source' hooks.
autocmd MyAutoCmd VimEnter * call dein#call_hook('post_source')
" }}}

" === Commands {{{
" :DeinClean[!]
" https://github.com/yyotti/unix_settings/blob/master/vim/rc/plugins/dein.rc.vim
command! -nargs=0 -bang DeinClean call s:dein_clean(<bang>0)
function! s:dein_clean(force) abort
  if !exists('*delete')
    echom 'ERORR: delete() is not found.'
    return
  endif
  let del_all = a:force
  let del_list = dein#check_clean()
  let i = 0
  echom 'Delete ' . len(del_list) . ' plugins...'
  for p in del_list
    let i += 1
    if !del_all
      let ans = s:input(printf('[%d/%d] Delete %s ? [y/N/q/a] ',
            \ i, len(del_list), fnamemodify(p, ':~')))
      if type(ans) is type(0) && ans == -1
        " Cancel.(<C-c>)
        echom 'Cancel.'
        return
      endif
      echo ' '
      if (type(ans) is type(0) && ans == 0 ) || ans ==? 'q'
        " Cancel.(Esc or 'q')
        echom 'Cancel.'
        return
      elseif ans =~? '^a\%[ll]$'
        " Delete all.
        let del_all = 1
      elseif ans !~? '^\(y\%[es]\)$'
        " Not delete.
        continue
      endif
    endif
    " Delete plugin directory.
    echom printf('[%d/%d] Delete: %s', i, len(del_list), p)
    if delete(p, 'rf') != 0
      echom 'ERROR: Failed to delete the plugins: ' . p
    endif
  endfor
endfunction

" http://koturn.hatenablog.com/entry/2015/07/18/101510
" Return:
"   -1: <C-c>
"    0: <ESC>
"   otherwise: input string
function! s:input(...) abort
  new
  cnoremap <buffer> <Esc> __CANCELED__<CR>
  try
    let input = call('input', a:000)
    let input = input =~# '__CANCELED__$' ? 0 : input
  catch /^Vim:Interrupt$/
    let input = -1
  finally
    bwipeout!
    return input
  endtry
endfunction
" }}}
