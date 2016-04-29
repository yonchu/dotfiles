let g:lightline = {
        \ 'colorscheme': 'landscape',
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['fugitive', 'gitgutter', 'filename'],
        \   ],
        \   'right': [
        \     ['syntastic', 'lineinfo'],
        \     ['percent'],
        \     ['charvaluehex', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'tabline': {
        \   'left': [[ 'tabs' ]],
        \   'right': [[ 'close' ], ['spaceopts', 'cwd']]
        \ },
        \ 'component': {
        \   'cwd'      : '[%.35(%{fnamemodify(getcwd(), ":~")}%)]',
        \   'lineinfo' : '⭡ %3l:%-2v/%-2{col("$")-1}',
        \   'spaceopts': '[%{&et?"et":"noet"}|ts=%{&ts}|sw=%{&sw}|sts=%{&sts}|tw=%{&tw}]',
        \ },
        \ 'component_function': {
        \   'mode'         : 'LightLineMode',
        \   'modified'     : 'LightLineModified',
        \   'readonly'     : 'LightLineReadonly',
        \   'filename'     : 'LightLineFilename',
        \   'filetype'     : 'LightLineFiletype',
        \   'fileencoding' : 'LightLineFileencoding',
        \   'fileformat'   : 'LightLineFileformat',
        \   'charcode'     : 'LightLineCharCode',
        \   'fugitive'     : 'LightLineFugitive',
        \   'gitgutter'    : 'LightLineGitGutter',
        \   'search_status': 'anzu#search_status',
        \ },
        \ 'component_expand': {
        \   'syntastic'   : 'SyntasticStatuslineFlag',
        \   'charvaluehex': 'LightLineCharvaluehex',
        \ },
        \ 'component_type': {
        \   'syntastic': 'error',
        \ },
        \ }

if has('multi_byte')
    let g:lightline.separator    = {'left': '⮀', 'right': '⮂'}
    let g:lightline.subseparator = {'left': '⮁', 'right': '⮃'}
endif

function! LightLineModified()
  return &ft =~ 'help\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ' -' . bufnr('%') . '-' .
        \ ('' != LightLineModified() ? ' | ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⭠ '  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

function! LightLineGitGutter()
  if !exists('*GitGutterGetHunkSummary')
        \ || !get(g:, 'gitgutter_enabled', 0)
        \ || winwidth(0) <= 100
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed,
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in range(3)
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! LightLineCharCode()
  if winwidth(0) <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

function! LightLineCharvaluehex()
  if winwidth(0) <= 70
    return ''
  endif
  return "'%{matchstr(getline('.'), '.', col('.')-1)}' 0x%04.4B"
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
