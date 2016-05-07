let g:syntastic_enable_signs        = 1
let g:syntastic_enable_balloons     = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_loc_list       = 1

" Automatically running
"   mode(active/passive)
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes' : ['ruby', 'php', 'perl'],
      \ 'passive_filetypes': ['python', 'html', 'coffee', 'javascript']
      \ }

" python
let g:syntastic_python_checkers     = ["flake8", "pyflakes"]
" javascript
let g:syntastic_javascript_checkers = ["gjslint", "jshint"]
" coffee
let g:syntastic_coffee_checkers     = ["coffeelint", "coffee"]
