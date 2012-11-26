" バッファ再読み込み時の多重ロードを抑制
if exists("b:did_ftplugin_python")
  finish
endif
let b:did_ftplugin_python=1

" PEP 8 Indent rule
setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl nosmartindent
setl cindent
setl textwidth=80
setl colorcolumn=80
setl smartindent
setl cinwords=if,elif,else,for,while,try,except,finally,def,class

" Folding
setl foldmethod=indent
setl foldlevel=99


"------------------------------------
" Pydiction
"  辞書補完
"------------------------------------
"NeoBundleSource Pydiction
"let g:pydiction_location = '~/.vim/pydiction/complete-dict'
"let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

"------------------------------------
" pythoncomplete
"  オムニ補完
"------------------------------------
"NeoBundleSource pythoncomplete
"setlocal omnifunc=pythoncomplete#Complete
" オムに補完はpython-mode(RopeOmni)を使用

"------------------------------------
" Syntastic
"  多言語対応のシンタックスチェック
"
"  実行：,s
"  自動実行のトグル：,S
"  エラー一覧(QiuickFix)表示：,e
"------------------------------------
NeoBundleSource syntastic

" 優先順位: flake8 > pyflakes
"let g:syntastic_python_checker = "flake8"
let g:syntastic_python_checker = 'pyflakes'

" Automatically running
"   mode(active/passive)
"if !exists('syntastic_mode_map')
  "let syntastic_mode_map = {}
"endif
"let syntastic_mode_map.mode = 'active'
"let syntastic_mode_map = { 'mode': 'passive',
  "\ 'active_filetypes': ['python'],
  "\ 'passive_filetypes': [''] }

"------------------------------------
" python-mode
"  https://github.com/klen/python-mode
"  :help PythonModeOptions
"  :help PythonModeKeys
"  :help ropevim.txt
"------------------------------------
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
let g:pymode_lint = 1
" Disable pylint checking every save
let g:pymode_lint_write = 1
" Switch pylint, pyflakes, pep8, mccabe code-checkers
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
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
" Hold cursor in current window
" when quickfix is open
let g:pymode_lint_hold = 0

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

NeoBundleSource python-mode


"------------------------------------
" jedi-vim
"  https://github.com/davidhalter/jedi-vim
"------------------------------------
let g:jedi#goto_command = "<leader>gt"
let g:jedi#get_definition_command = "<leader>d"
let g:jedi#pydoc = "<space>K"
let g:jedi#rename_command = "<leader>R"
let g:jedi#related_names_command = "<leader>n"
NeoBundleSource jedi-vim
