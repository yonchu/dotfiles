let g:unite_source_menu_menus.zsh = {
      \   'description' : 'zsh',
      \ }
let g:unite_source_menu_menus.zsh.edit_zsh = {
      \   'description' : 'Edit zsh files.',
      \ }
let g:unite_source_menu_menus.zsh.edit_zsh.file_candidates = [
      \   ['zshenv'    , '~/.zsh/.zshenv'],
      \   ['zprofile'  , '~/.zsh/.zprofile'],
      \   ['zshrc'     , '~/.zsh/.zshrc'],
      \   ['zalias'    , '~/.zsh/.zalias'],
      \   ['zlogin'    , '~/.zsh/.zlogin'],
      \   ['zlogout'   , '~/.zsh/.zlogout'],
      \   ['zsh_history'    , '~/.zsh_history'],
      \   ['zsh_session'    , '~/.zsh_session'],
      \ ]
