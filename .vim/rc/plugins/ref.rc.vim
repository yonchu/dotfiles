let g:ref_use_cache = 1
let g:ref_use_vimproc = 1
let is_windows = has('win16') || has('win32') || has('win64')
if is_windows
  let g:ref_refe_encoding = 'cp932'
else
  let g:ref_refe_encoding = 'euc-jp'
endif

" ref-lynx.
if is_windows
  let lynx = 'C:/lynx/lynx.exe'
  let cfg  = 'C:/lynx/lynx.cfg'
  let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
  let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
endif
let g:ref_lynx_use_cache = 1
let g:ref_lynx_start_linenumber = 0 " Skip.
let g:ref_lynx_hide_url_number = 0

autocmd MyAutoCmd FileType ref call s:ref_my_settings()
function! s:ref_my_settings() abort
  " Overwrite settings.
  nmap <buffer> [Tag]t  <Plug>(ref-keyword)
  nmap <buffer> [Tag]p  <Plug>(ref-back)
  nmap <buffer> b <Plug>(ref-back)
  nmap <buffer> f <Plug>(ref-forward)
  "setlocal nonumber
endfunction

" PHPマニュアルのパスを指定
let g:ref_phpmanual_path = $HOME . '/work/dev/docs/php-chunked-xhtml'

" Javadocのパスを指定
let g:ref_javadoc_path = $HOME . '/work/dev/docs/java6_ja_apidocs'

" jqueryリファレンスのパスを指定
let g:ref_jquery_doc_path = $HOME . '/work/dev/docs/jqapi-latest'

" javascriptリファレンスのパスを指定
let g:ref_javascript_doc_path = $HOME . '/work/dev/docs/jsref/htdocs'
