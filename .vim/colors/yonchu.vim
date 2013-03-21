" yonchu.vim

" === Setup {{{
hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'yonchu'

set background=dark
" }}}

" === Utilities {{{
" http://noahfrederick.com/vim-color-scheme-hemisu/
function! s:h(group, style)
  execute 'highlight' a:group
      \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
      \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
      \ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp.gui   : 'NONE')
      \ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui      : 'NONE')
      \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
      \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
      \ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm    : 'NONE')
endfunction
" }}}

" === Basic Colors {{{
" Black         0
" White        15
"
" Gray        248
" Red           9
" Green        10
" Yellow       11
" Blue         12
" Magenta      13
" Cyan         14
"
" DarkGray    242
" DarkRed       1
" DarkGreen     2
" DarkYellow  130
" DarkBlue      4
" DarkMagenta   5
" DarkCyan      6
"
" LightGray      7
" LightRed     224
" LightGreen   121
" LightYellow  229
" LightBlue     81
" LightMagenta 225
" LightCyan    159

let s:black         = {'gui': '#1A1C1A', 'cterm': 'Black'}
let s:white         = {'gui': '#f5f5f5', 'cterm': 'White'}        " QB's body

let s:gray          = {'gui': '#6a6767', 'cterm': 'Gray'}         " Transformed Homura's hair
let s:red           = {'gui': '#d64073', 'cterm': 'Red'}          " QB's eye
let s:green         = {'gui': '#90b1aa', 'cterm': 'Green'}        " Kyoko's parker
let s:yellow        = {'gui': '#f9d59d', 'cterm': 'Yellow'}       " Mami's hair
let s:blue          = {'gui': '#5b7397', 'cterm': 'Blue'}         " Sayaka's plate
let s:magenta       = {'gui': '#ffc1c6', 'cterm': 'Magenta'}      " Transformed Madoka's hair
let s:cyan          = {'gui': '#88afc0', 'cterm': 'Cyan'}         " Transformed Sayaka's hair

let s:dark_gray     = {'gui': '#464143', 'cterm': 'DarkGray'}     " Homura's hair
let s:dark_red      = {'gui': '#7f3946', 'cterm': 'DarkRed'}      " Kyoko's skirt
let s:dark_green    = {'gui': '#709167', 'cterm': 'DarkGreen'}
let s:dark_yellow   = {'gui': '#4c3f38', 'cterm': 'DarkYellow'}   " Mami's boots
let s:dark_blue     = {'gui': '#404557', 'cterm': 'DarkBlue'}     " Sayaka's sox
let s:dark_magenta  = {'gui': '#b15e6e', 'cterm': 'DarkMagenta'}  " Transformed Kyoko's hair
let s:dark_cyan     = {'gui': '#88afc0', 'cterm': 'DarkCyan'}

let s:light_gray    = {'gui': '#464143', 'cterm': 'LightGray'}
let s:light_red     = {'gui': '#7f3946', 'cterm': 'LightRed'}
let s:light_green   = {'gui': '#709167', 'cterm': 'LightGreen'}
let s:light_yellow  = {'gui': '#4c3f38', 'cterm': 'LightYellow'}
let s:light_blue    = {'gui': '#404557', 'cterm': 'LightBlue'}
let s:light_magenta = {'gui': '#b15e6e', 'cterm': 'LightMagenta'}
let s:light_cyan    = {'gui': '#88afc0', 'cterm': 'LightCyan'}
" }}}

" === Color set {{{
let s:normal           = s:white
let s:bg               = s:black
let s:obbligato        = s:magenta
let s:plain            = s:magenta
let s:ok               = s:green
let s:annotate         = s:yellow
let s:fatal            = s:dark_red
let s:invisible        = {'gui': '#6a6767', 'cterm': 8}
let s:hidden           = s:dark_gray
let s:charm            = s:dark_magenta
let s:subdued_annotate = s:dark_yellow
let s:accent           = s:red
let s:composed         = s:green
let s:highlight        = s:dark_cyan

let s:visual = {
      \  'bg': {'gui': '#606060', 'cterm': '16'}}

let s:cursorline_normal = {
      \  'bg': {'gui': 'NONE', 'cterm': '235'},
      \  'gui': 'underline'}
let s:cursorline_insert = {
      \  'bg': {'gui': 'NONE', 'cterm': '18'},
      \  'gui': 'underline'}

let s:colorcolumn = {
      \ 'bg': {'gui': '#1A1C1A', 'cterm': 232}}

let s:zenkakuspace = {
      \  'fg'   : s:gray,
      \  'bg'   : s:blue,
      \  'cterm': 'underline',
      \  'gui'  : 'underline'}

" IndentGuides
let s:indent_guides_odd = {
      \ 'bg': {'gui': '#1A1C1A', 'cterm': 234}}
let s:indent_guides_even = {
      \ 'bg': {'gui': '#1A1C1A', 'cterm': 14}}

" vim-hier
let s:qf_error_ucurl = {
      \  'cterm': 'undercurl',
      \  'gui'  : 'undercurl',
      \  'guisp': 'red'}
let s:qf_warning_ucurl = {
      \  'cterm': 'undercurl',
      \  'gui'  : 'undercurl',
      \  'guisp': 'blue'}

" showmarks
let s:showmarks_hll = {
      \ 'bg': s:black,
      \ 'fg': s:blue}
let s:showmarks_hlu = {
      \ 'bg': s:light_yellow,
      \ 'fg': s:blue}
let s:showmarks_hlo = {
      \ 'bg': s:black,
      \ 'fg': s:blue}
let s:showmarks_hlm = {
      \ 'bg': s:black,
      \ 'fg': s:blue,
      \ 'gui': 'bold'}

" }}}

" === Highlight {{{1
" UI {{{2
call s:h('Normal',      {'fg': s:normal, 'bg': s:bg})
" call s:h('Cursor',      {'fg': s:bg, 'bg': s:obbligato})
call s:h('Folded',      {'fg': s:accent, 'gui': 'bold', 'cterm': 'bold'})
call s:h('FoldColumn',  {'fg': s:normal})
call s:h('ModeMsg',     {'fg': s:ok, 'gui': 'bold', 'cterm': 'bold'})
call s:h('WarningMsg',  {'fg': s:annotate, 'gui': 'bold', 'cterm': 'bold'})
call s:h('ErrorMsg',    {'fg': s:fatal, 'gui': 'bold', 'cterm': 'bold'})
call s:h('LineNr',      {'fg': s:hidden})
call s:h('SpecialKey',  {'fg': s:hidden})
call s:h('NonText',     {'fg': s:hidden})
call s:h('MatchParen',  {'fg': s:obbligato, 'bg': s:hidden})
call s:h('Pmenu',       {'bg': s:subdued_annotate})
call s:h('PmenuSel',    {'fg': s:green, 'bg': s:charm})
call s:h('Title',       {'fg': s:accent, 'gui': 'bold', 'cterm': 'bold'})
call s:h('VertSplit',   {'fg': s:hidden, 'bg': s:invisible})
call s:h('Question',    {'fg': s:ok, 'gui': 'bold', 'cterm': 'bold'})
call s:h('Search',      {'bg': s:highlight})
call s:h('SpellBad',    {'sp': s:fatal, 'gui': 'undercurl'})
call s:h('TabLine',     {'fg': s:normal, 'bg': s:subdued_annotate})
call s:h('TabLineFill', {'fg': s:normal, 'bg': s:subdued_annotate})
call s:h('TabLineSel',  {'fg': s:green, 'bg': s:charm})

call s:h('Visual',      s:visual)
call s:h('ColorColumn', s:colorcolumn)
call s:h('CursorLine',  s:cursorline_normal)

" }}}

" Diff {{{2
call s:h('DiffAdd',    {'fg': s:ok})
call s:h('DiffChange', {'fg': s:annotate})
call s:h('DiffDelete', {'fg': s:fatal})
call s:h('DiffText',   {'fg': s:charm, 'gui': 'bold', 'cterm': 'bold'})
" }}}

" Syntax {{{2
call s:h('Delimiter',  {'fg': s:invisible})
call s:h('Comment',    {'fg': s:invisible})
call s:h('Underlined', {'gui': 'underline', 'cterm': 'underline'})
call s:h('Type',       {'fg': s:annotate})
call s:h('Identifier', {'fg': s:accent})
call s:h('Constant',   {'fg': s:composed})
call s:h('Statement',  {'fg': s:plain})
call s:h('Todo',       {'bg': s:subdued_annotate})
" }}}

" ZenkakuSpace {{{2
call s:h('ZenkakuSpace',  s:zenkakuspace)
match ZenkakuSpace /　/
" }}}

" IndentGuides {{{2
call s:h('IndentGuidesOdd',  s:indent_guides_odd)
call s:h('IndentGuidesEven', s:indent_guides_even)
" }}}

" vim-hier {{{2
call s:h('qf_error_ucurl',    s:qf_error_ucurl)
call s:h('qf_warning_ucurl',  s:qf_warning_ucurl)
" }}}

" showmarks {{{2
call s:h('ShowMarksHLl',  s:showmarks_hll)
call s:h('ShowMarksHLu',  s:showmarks_hlu)
call s:h('ShowMarksHLo',  s:showmarks_hlo)
call s:h('ShowMarksHLm',  s:showmarks_hlm)
" }}}

" Link {{{2
hi! link IncSearch Search
hi! link MoreMsg ModeMsg
hi! link Function Identifier
hi! link PreProc Statement
hi! link Special NonText
hi! link Error ErrorMsg
hi! link htmlTag Type
hi! link htmlEndTag htmlTag

hi! link VisualNOS Visual
" }}}

" }}}

augroup YonchuColorAu
  autocmd!
  " Change cursor color according to the mode(NomalMode, InsertMode)
  autocmd InsertEnter * highlight CursorLine gui=underline ctermbg=18
  autocmd InsertLeave * highlight CursorLine gui=underline ctermbg=235
augroup END

