let g:unite_source_menu_menus.enc = {
      \     'description' : 'Open with a specific character code again.',
      \ }
let g:unite_source_menu_menus.enc.command_candidates = [
      \       ['utf8', 'Utf8'],
      \       ['iso2022jp', 'Iso2022jp'],
      \       ['cp932', 'Cp932'],
      \       ['euc', 'Euc'],
      \       ['utf16', 'Utf16'],
      \       ['utf16-be', 'Utf16be'],
      \       ['jis', 'Jis'],
      \       ['sjis', 'Sjis'],
      \       ['unicode', 'Unicode'],
      \     ]
let g:unite_source_menu_menus.fenc = {
      \     'description' : 'Change file fenc option.',
      \ }
let g:unite_source_menu_menus.fenc.command_candidates = [
      \       ['utf8', 'WUtf8'],
      \       ['iso2022jp', 'WIso2022jp'],
      \       ['cp932', 'WCp932'],
      \       ['euc', 'WEuc'],
      \       ['utf16', 'WUtf16'],
      \       ['utf16-be', 'WUtf16be'],
      \       ['jis', 'WJis'],
      \       ['sjis', 'WSjis'],
      \       ['unicode', 'WUnicode'],
      \     ]
let g:unite_source_menu_menus.ff = {
      \     'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.ff.command_candidates = {
      \       'unix'   : 'WUnix',
      \       'dos'    : 'WDos',
      \       'mac'    : 'WMac',
      \     }
let g:unite_source_menu_menus.unite = {
      \     'description' : 'Start unite sources',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = {
      \       'buffer_tab'      : 'Unite buffer_tab',
      \       'bookmark'        : 'Unite bookmark',
      \       'colorscheme'     : 'Unite -auto-preview -winwidth=15',
      \       'command'         : 'Unite command',
      \       'find'            : 'Unite find',
      \       'filetype'        : 'Unite filetype filetype/new',
      \       'directory'       : 'Unite -buffer-name=files -default-action=lcd directory_mru',
      \       'output/shllcmd'  : 'Unite -log -wrap output/shellcmd',
      \       'quickfix'        : 'Unite qflist -no-quit',
      \       'scriptnames'     : 'Unite output:scriptnames',
      \     }
let g:unite_source_menu_menus.zsh = {
      \     'description' : 'Edit zsh files.',
      \ }
let g:unite_source_menu_menus.zsh.file_candidates = [
      \       ['zshenv'    , '~/.zsh/.zshenv'],
      \       ['zprofile'  , '~/.zsh/.zprofile'],
      \       ['zshrc'     , '~/.zsh/.zshrc'],
      \       ['zalias'    , '~/.zsh/.zalias'],
      \       ['zlogin'    , '~/.zsh/.zlogin'],
      \       ['zlogout'   , '~/.zsh/.zlogout'],
      \       ['zsh_history'    , '~/.zsh_history'],
      \       ['zsh_session'    , '~/.zsh_session'],
      \     ]
