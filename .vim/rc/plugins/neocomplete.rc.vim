"=== Introduction ========================================================={{{
"
"  neocomplete.rc.vim
"
"   neocomplete.vim settings
"
"   https://github.com/Shougo/neocomplete
"
"   補完候補のPrefix
"    file              -> [F] {filename}
"    file/include      -> [FI] {filename}
"    dictionary        -> [D] {words}
"    member            -> [M] member
"    buffer            -> [B] {buffer}
"    syntax            -> [S] {syntax-keyword}
"    include           -> [I]
"    neosnippet        -> [neosnip]
"    UltiSnips         -> [US]
"    vim               -> [vim] type
"    omni              -> [O]
"    tag               -> [T]
"    other sources     -> [plugin-name-prefix]
"
"==========================================================================}}}

" === Basic {{{
let g:neocomplete#enable_auto_close_preview = 1

let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case  = 1
let g:neocomplete#enable_camel_case  = 1

let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:neocomplete#disable_auto_select_buffer_name_pattern =
      \ '\[Command Line\]'

let g:neocomplete#enable_auto_delimiter = 1
if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.vim = ['#']
let g:neocomplete#delimiter_patterns.cpp = ['::']
let g:neocomplete#delimiter_patterns.php = ['->', '::', '\']

let g:neocomplete#ignore_source_files = []

" custom#source
call neocomplete#custom#source('look', 'min_pattern_length', 4)
" call neocomplete#custom#source('_', 'sorters', [])
call neocomplete#custom#source('_', 'converters',
      \ ['converter_add_paren', 'converter_remove_overlap',
      \  'converter_delimiter', 'converter_abbr'])

" }}}

" === Dictionary completion {{{
" vimのデフォルト辞書を指定
set dictionary&
      \ dictionary+=~/.vim/dict/_.dict,~/dotfiles.local/.vim/dict/_.dict

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ '_'            : expand('$DOTVIM/dict/_.dict').','.expand('~/dotfiles.local/.vim/dict/_.dict'),
      \ 'default'      : '',
      \ 'scala'        : expand('$DOTVIM/dict/scala.dict'),
      \ 'java'         : expand('$DOTVIM/dict/java.dict'),
      \ 'c'            : expand('$DOTVIM/dict/c.dict'),
      \ 'cpp'          : expand('$DOTVIM/dict/cpp.dict'),
      \ 'css'          : expand('$DOTVIM/dict/css.dict'),
      \ 'javascript'   : expand('$DOTVIM/dict/javascript.dict'),
      \ 'ocaml'        : expand('$DOTVIM/dict/ocaml.dict'),
      \ 'perl'         : expand('$DOTVIM/dict/perl.dict'),
      \ 'php'          : expand('$DOTVIM/dict/php.dict'),
      \ 'ruby'         : expand('$DOTVIM/dict/ruby.dict'),
      \ 'scheme'       : expand('$DOTVIM/dict/scheme.dict'),
      \ 'vim'          : expand('$DOTVIM/dict/vim.dict'),
      \ 'vimshell'     : expand('~/.vimshell_hist'),
      \ 'int-termtter' : expand('~/.vimshell/int-history/int-termtter'),
      \ }

if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif

let g:neocomplete#same_filetypes.bash = 'sh'
let g:neocomplete#same_filetypes.c = 'cpp,d'
let g:neocomplete#same_filetypes.coffee = 'javascript,jquery'
let g:neocomplete#same_filetypes.cpp = 'c'
let g:neocomplete#same_filetypes.erlang = 'man'
let g:neocomplete#same_filetypes.gitconfig = '_'
let g:neocomplete#same_filetypes.javascript = 'jquery'
let g:neocomplete#same_filetypes.jquery = 'javascript'
let g:neocomplete#same_filetypes.less = 'css'
let g:neocomplete#same_filetypes.objc = 'c'
let g:neocomplete#same_filetypes.perl = 'ref,man'
let g:neocomplete#same_filetypes.tt2html = 'html,perl'
let g:neocomplete#same_filetypes.zsh = 'sh'
let g:neocomplete#same_filetypes._ = '_'
" }}}

" === Keyword completion {{{
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns._ = '\h\k*(\?'
let g:neocomplete#keyword_patterns.coffee = '\h\w*@\h\w*'
let g:neocomplete#keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::\w*'
let g:neocomplete#keyword_patterns.rst =
      \ '\$\$\?\w*\|[[:alpha:]_.\\/~-][[:alnum:]_.\\/~-]*\|\d\+\%(\.\d\+\)\+'
" }}}

" === Omni completion {{{
" Set omnifunc.
autocmd MyAutoCmd FileType javascript     setlocal omnifunc=tern#Complete
autocmd MyAutoCmd FileType coffee         setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType css,less       setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
autocmd MyAutoCmd FileType c              setlocal omnifunc=ccomplete#Complete
autocmd MyAutoCmd FileType ruby           setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

" go
let g:neocomplete#sources#omni#functions.go =
      \ 'gocomplete#Complete'
" java (disable)
" let g:neocomplete#sources#omni#input_patterns.java = ''
" lua
let g:neocomplete#sources#omni#input_patterns.lua =
      \ '\w\+[.:]\|require\s*(\?["'']\w*'
let g:neocomplete#sources#omni#functions.lua =
      \ 'xolox#lua#omnifunc'
" perl
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" php
let g:neocomplete#sources#omni#input_patterns.php =
      \'\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
" python
let g:neocomplete#sources#omni#input_patterns.python =
      \ '[^. *\t]\.\w*\|\h\w*'
let g:neocomplete#force_omni_input_patterns.python =
      \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" ruby
" let g:neocomplete#sources#omni#input_patterns.ruby =
"      \ '[^. *\t]\.\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.ruby =
"      \ '[^. *\t]\.\w*\|\h\w*::\w*'
" vim
let g:neocomplete#sources#vim#complete_functions = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \ 'VimShellExecute' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShellInteractive' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShellTerminal' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShell' : 'vimshell#complete',
      \ 'VimFiler' : 'vimfiler#complete',
      \ 'Vinarise' : 'vinarise#complete',
      \ }
" }}}

" === Mappings {{{
" Page move.
inoremap <expr><C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b>  pumvisible() ? "\<PageUp>"   : "\<Left>"

" Close popup and delete backword char.
inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplete#smart_close_popup()."\<BS>"

" undo
inoremap <expr><C-g>     neocomplete#undo_completion()

" Manual completion.
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
inoremap <expr> '    pumvisible() ? "\<C-y>" : "'"
" Common completion.
inoremap <expr><C-l>     neocomplete#complete_common_string()
" File name completion.
inoremap <expr><C-x><C-f>  neocomplete#start_manual_complete('file')
" look completion.
inoremap <silent><expr> <C-x><C-l>
      \ neocomplete#start_manual_complete('look')
" Omni completion.
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplete#start_manual_complete('omni')

" <CR>: neocomplete & neosnippet.
imap <expr><CR>
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ?
      \ "\<C-y>" : "\<CR>"

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" :
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" For cursor moving in insert mode(Not recommended).
inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"

" <Up><Down>: Select completion.
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
" }}}

" === Utility {{{
" ファイル名を取得
"   http://d.hatena.ne.jp/cooldaemon/searchdiary?word=snippets
function! Filename(...)
  let filename = expand('%:t:r')
  if filename == '' | return a:0 == 2 ? a:2 : '' | endif
  return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endf
" }}}

let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

" vim: fdm=marker:
