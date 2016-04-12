" Commands.
"   :TernDef        Jump to the definition of the thing under the cursor.
"   :TernDefPreview Look up definition in preview
"   :TernDefSplit   Look up definition in new split
"   :TernDefTab     Look up definition in new tab
"   :TernDoc        Look up the documentation of something.
"   :TernDocBrowse  Browse the Documentation.
"   :TernType       Find the type of the thing under the cursor.
"   :TernRefs       Show all references to the variable or property under the cursor.
"   :TernRename     Rename the variable under the cursor.

" Show argumet hints. (no/on_move/on_hold) (Default: no)
let g:tern_show_argument_hints = 'on_hold'

" Set default key mappings.
" let g:tern_map_keys = 1
" Set prefix key.
" let g:tern_map_prefix = '<leader>'

" Key mapping list.
"   prefix + td   :TernDoc<CR>'
"   prefix + tb   :TernDocBrowse<CR>'
"   prefix + tt   :TernType<CR>'
"   prefix + td   :TernDef<CR>'
"   prefix + tpd  :TernDefPreview<CR>'
"   prefix + tsd  :TernDefSplit<CR>'
"   prefix + ttd  :TernDefTab<CR>'
"   prefix + tr   :TernRefs<CR>'
"   prefix + tR   :TernRename<CR>'

" Run ftplugin process.
" NeoBundleLazyだと after/ftplugin/javascript_tern.vim が読み込まれない
call tern#Enable()

" Menu
menu <silent> Tern.Jump\ To\ Defintion :TernDef<CR>
menu <silent> Tern.See\ Documentation :TernDoc<CR>
menu <silent> Tern.DataType :TernType <CR>
menu <silent> Tern.Show\ all\ References :TernRefs<CR>
menu <silent> Tern.Rename :TernRename <CR>
