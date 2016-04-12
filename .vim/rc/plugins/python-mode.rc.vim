" ## Run python
" Load run code plugin
let g:pymode_run = 0
" Key for run python code
let g:pymode_run_key = '<Leader>r'

" ## Show documentation
" Load show documentation plugin
let g:pymode_doc = 0
" Key for show python documentation
let g:pymode_doc_key = 'K'

" ## Lint
" Load pylint code plugin
let g:pymode_lint = 0
" Disable pylint checking every save
let g:pymode_lint_write = 1
" Switch pylint, pyflakes, pep8, mccabe code-checkers
let g:pymode_lint_checker = "pep8,pyflakes,mccabe"
" on django
"let g:pymode_lint_cheker = "pylint"

" ## Window
" Hold cursor in current window
" when quickfix is open
let g:pymode_lint_hold = 0
" Minimal height of pylint error window
let g:pymode_lint_minheight = 3
" Maximal height of pylint error window
let g:pymode_lint_maxheight = 6

" ## Indent
let g:pymode_indent = 0

"## Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"## Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" ## Foldin
" Enable python folding
let g:pymode_folding = 1

" ## Rope
" Load rope plugin
let g:pymode_rope = 0
" Auto create and open ropeproject
let g:pymode_rope_auto_project = 0

" ## etc
" Auto fix vim python paths if virtualenv enabled
let g:pymode_virtualenv = 1
