let g:watchdogs_filetype_checkers = {
      \  'coffee' : [ 'coffeelint', 'coffee' ],
      \  'python' : [ 'flake8', 'pyflakes', 'pep8' ],
      \}

let g:watchdogs_quickrun_config = {
      \  'runner/vimproc/updatetime' : 40,
      \}

let g:watchdogs_quickrun_post_config = {
      \  'hook/close_quickfix/enable_exit' : 0,
      \}

let g:watchdogs_checkers = {
      \ 'jshint' : {
      \   'command' : 'jshint',
      \   'exec'    : '%c --verbose %s:p',
      \   'errorformat' : '%f: line %l\, col %c\, %m,%-G%.%#error%.%#,%-G',
      \  },
      \}

" Auto run BufWritePost.
let g:watchdogs_check_BufWritePost_enables = {
      \  'c'          : 0,
      \  'coffee'     : 3,
      \  'cpp'        : 0,
      \  'javascript' : 3,
      \  'perl'       : 1,
      \  'php'        : 1,
      \  'python'     : 3,
      \  'ruby'       : 1,
      \  'sass'       : 1,
      \  'scss'       : 1,
      \}

" Auto run CursorMovedI.
" let g:watchdogs_check_CursorHold_enables = {
"       \  'haskell' : 1,
"       \  'coffee'  : 3,
"       \}
