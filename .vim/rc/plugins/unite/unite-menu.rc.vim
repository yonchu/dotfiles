let g:unite_source_menu_menus.vim = {
      \   'description' : 'vim',
      \ }

let g:unite_source_menu_menus.vim.basic = {
      \   'description' : 'vim basic features.',
      \ }
let g:unite_source_menu_menus.vim.user = {
      \   'description' : 'vim user custom features.',
      \ }
let g:unite_source_menu_menus.vim.plugins = {
      \   'description' : 'vim plugin features.',
      \ }
let g:unite_source_menu_menus.vim.help = {
      \   'description' : 'help.',
      \ }
let g:unite_source_menu_menus.vim.help.command_candidates = {
      \   'User manual.'     : 'help usr_toc',
      \   'Quick refarence.' : 'help quickref',
      \   'Command list.'    : 'help index',
      \   'Option list.'     : 'help option-list',
      \   'Tips.'            : 'help tips',
      \   'Startup Options.' : 'help startup-options',
      \   'Motion.'          : 'help motion',
      \   'text-object.'     : 'help text-objects',
      \   'Window.'          : 'help windows',
      \   'Tabpage.'         : 'help tabpage',
      \   'Regex pattern.'   : 'help pattern-overview',
      \   'vim script.'      : 'help usr_41',
      \   'Function list.'   : 'help function-list',
      \   'How to write plugin.'   : 'help write-plugin',
      \   'How to write ftplugin.' : 'help write-filetype-plugin',
      \   'How to write help.'     : 'help help-writing',
      \ }

let g:unite_source_menu_menus.vim.user.encoding = {
      \   'description' : 'encoding.',
      \ }
let g:unite_source_menu_menus.vim.user.encoding.enc = {
      \   'description' : 'Open with a specific character code again.',
      \ }
let g:unite_source_menu_menus.vim.user.encoding.enc.enccommand_candidates = [
      \   ['utf8', 'Utf8'],
      \   ['iso2022jp', 'Iso2022jp'],
      \   ['cp932', 'Cp932'],
      \   ['euc', 'Euc'],
      \   ['utf16', 'Utf16'],
      \   ['utf16-be', 'Utf16be'],
      \   ['jis', 'Jis'],
      \   ['sjis', 'Sjis'],
      \   ['unicode', 'Unicode'],
      \ ]

let g:unite_source_menu_menus.vim.user.encoding.fenc = {
      \   'description' : 'Change file fenc option.',
      \ }
let g:unite_source_menu_menus.vim.user.encoding.fenc.command_candidates = [
      \   ['utf8', 'WUtf8'],
      \   ['iso2022jp', 'WIso2022jp'],
      \   ['cp932', 'WCp932'],
      \   ['euc', 'WEuc'],
      \   ['utf16', 'WUtf16'],
      \   ['utf16-be', 'WUtf16be'],
      \   ['jis', 'WJis'],
      \   ['sjis', 'WSjis'],
      \   ['unicode', 'WUnicode'],
      \ ]

let g:unite_source_menu_menus.vim.user.encoding.ff = {
      \   'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.vim.user.encoding.ff.command_candidates = {
      \   'unix'   : 'WUnix',
      \   'dos'    : 'WDos',
      \   'mac'    : 'WMac',
      \ }

let g:unite_source_menu_menus.vim.plugins.unite = {
      \   'description' : 'Start unite sources',
      \ }
let g:unite_source_menu_menus.vim.plugins.unite.command_candidates = {
      \   'buffer_tab'      : 'Unite buffer_tab',
      \   'bookmark'        : 'Unite bookmark',
      \   'colorscheme'     : 'Unite -auto-preview -winwidth=15',
      \   'command'         : 'Unite command',
      \   'find'            : 'Unite find',
      \   'filetype'        : 'Unite filetype filetype/new',
      \   'directory'       : 'Unite -buffer-name=files -default-action=lcd directory_mru',
      \   'output/shllcmd'  : 'Unite -log -wrap output/shellcmd',
      \   'quickfix'        : 'Unite qflist -no-quit',
      \   'scriptnames'     : 'Unite output:scriptnames',
      \ }
