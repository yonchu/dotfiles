" ============================================================================
"
"  .vimrc
"
" ============================================================================

" === Initialization ====================================================={{{1
" Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

" if has('vim_starting')
"   " Print vim startup time.
"   if has('reltime')
"     let g:startuptime = reltime()
"     augroup VimStartUpTimeAu
"       autocmd!
"       autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
"       \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
"     augroup END
"   endif
" endif

" OS detection flag.
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \ || (!executable('xdg-open') && system('uname') =~? '^darwin'))

" Language.
if s:is_windows
  " For Windows.
  language messages ja_JP
elseif s:is_mac
  " For Mac.
  language messages C
  " language ctype C
  language time C
else
  " For Linux.
  language messages C
endif

" Help language.
set helplang& helplang=ja,en

" shortmess.
" Don't give the intro message when starting Vim.
" Abbreviate all messages.
set shortmess& shortmess=atToOI
" Ddon't give |ins-completion-menu| messages.
" http://qiita.com/koara-local/items/40153e1135bb8101cf2d
if has('patch-7.4.314')
  set shortmess+=c
endif
" Don't give the file info when editing a file.
if has('patch-7.4.1570')
  set shortmess+=F
endif

" Change path separator to slash(/) for Win.
if s:is_windows && exists('+shellslash')
  set shellslash
endif

" vim directory.
"   Windows   : $VIM/vimfiles
"   Linux/Mac : ~/.vim
if s:is_windows
  let $DOTVIM = expand('~/vimfiles')
else
  let $DOTVIM = expand('~/.vim')
endif

" Set .gvimrc path.
if !exists('$MYGVIMRC')
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" cache directory.
let $CACHE = expand('~/.cache')
if !isdirectory(expand($CACHE))
  echoerr '[WARNING] "' . $CACHE , '" does not exist. Run mkdir -p ' . expand($CACHE)
  echoerr '-> mkdir -p ' . expand($CACHE)
  call mkdir(expand($CACHE), 'p')
endif

" Save current working directory for a tab page.
let t:cwd = getcwd()

" Set <Leader> key (default: \) for global plugin.
let g:mapleader = ','
" Set <LocalLeader> key for filetype plugin to avoid conflicts.
" let g:maplocalleader = '\'

" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

augroup MyAutoCmd
  autocmd!
augroup END

" Disable menu.vim.
" This flag(M) must be added in the .vimrc file, before switching on syntax or
" filetype recognition (when the |gvimrc| file is sourced the system menu has
" already been loaded; the ':syntax on' and ':filetype on' commands load the menu too).
if has('gui_running')
  set guioptions+=M
endi
" Disable menu for GUI. (:help menus)
let did_install_default_menus = 1
let did_install_syntax_menu   = 1


" Disable default plugins.
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_matchparen        = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
" }}}

" === Define functions ==================================================={{{1
" Anywhere SID.
function! s:SID_PREFIX() abort
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Toggle options.
function! ToggleOption(option_name) abort
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction

" Toggle variables.
function! ToggleVariable(variable_name) abort
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction

" Execute with selected text.
" (for open-browser.vim)
"http://deris.hatenablog.jp/entry/2013/07/05/023835
function! ExecuteWithSelectedText(command) abort
  if a:command !~? '%s'
    return
  endif
  let reg = '"'
  let [save_reg, save_type] = [getreg(reg), getregtype(reg)]
  normal! gvy
  let selectedText = @"
  call setreg(reg, save_reg, save_type)
  if selectedText == ''
    return
  endif
  execute printf(a:command, selectedText)
endfunction
" }}}

" === Dein ==============================================================={{{1
if filereadable(expand('~/.vim/rc/plugins/dein.rc.vim'))
  execute 'source' expand('~/.vim/rc/plugins/dein.rc.vim')
endif

syntax enable
filetype plugin indent on
" }}}

" === Encoding ==========================================================={{{1
"  http://d.hatena.ne.jp/ka-nacht/20080220/1203433500
"  http://www.kawaz.jp/pukiwiki/?vim#cb691f26
"  http://d.hatena.ne.jp/over80/20080907/1220794834
"
"  encoding
"   vim内部で使用する文字コード
"   バッファ/レジスタ/vimスクリプトなどの文字列に適用される
"   vim全体で共通のグローバルオプション
"   新規ファイル作成時にfileencodingが未指定の場合にも使用される
"
"  fileencoding
"   新規ファイル作成時またはバッファ保存時に使用される文字コード
"   (ファイルの文字コードと言えばこの値を指す)
"   バッファ毎に指定可能なバッファローカルオプション
"   encodingと異なる場合は保存時にfileencodingへ変換される
"   fileencodingを変更したい場合は setlocal にて変更する必要がある
"   set にて変更した場合はグローバル値が変更されるため、以降に新規作成される
"   バッファの保存時に適用される文字コードが変わってしまう
"
"  fileencodings
"   文字コードの自動判別優先順位
"   カンマ区切りで指定され、左側の設定が優先される
"   判別方法は左から順に変換を行い最初に成功した値が適用される
"   変換途中にencodingまたはfileencodingと同じ値を発見した場合は判定を中断し
"   その値を適用する
"   自動判別に失敗した場合は encoding の値が適用される
"
"  fileformat
"   改行コード(unix=LF, dos=CRLF, mac=CR)
"
"  fileformats
"   改行コードの自動判別優先順位
" ============================================================================

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
  if s:is_windows && !has('gui_running')
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif

"Setting of terminal encoding.
if !has('gui_running')
  if $ENV_ACCESS ==# 'linux'
    set termencoding=euc-jp
  elseif $ENV_ACCESS ==# 'colinux'
    set termencoding=utf-8
  else  " fallback
    set termencoding=  " same as 'encoding'
  endif
elseif s:is_windows
  " For system.
  set termencoding=cp932
endif

" The automatic recognition of the character code.
if has('kaoriya')
  " For Kaoriya only.
   set fileencodings=guess
elseif !exists('did_encoding_settings') && has('iconv')
  " Build encodings.
  let &fileencodings = join([
        \ 'ucs-bom', 'iso-2022-jp-3', 'utf-8', 'euc-jp', 'cp932'])
  let did_encoding_settings = 1
endif

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() abort
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction
autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

" For multi-byte sign: □ ,◯
" Use only 'auto' for Win-Kaoriya.
if &ambiwidth !=# 'auto'
  set ambiwidth=double
endif

" IME OFF when leave insert mode.
"   Mac('xim')          : Use Karabiner.
"   Win(multi_byte_ime) : http://d.hatena.ne.jp/r7kamura/20110217/1297910068
if has('multi_byte_ime')
  " Enable IM.
  set noimdisable
  " IM(Input Method).
  "   0: lmap:OFF IM:OFF
  "   1: lmap:ON  IM:OFF
  "   2: lmap:OFF IM:ON
  set iminsert=0
  set imsearch=0
  set noimcmdline
endif
" }}}

" === Backup ============================================================={{{1
" Backup on.
" set backup
" set swapfile
" set backupdir=~/backup

" Backup off.
set nobackup
set noswapfile

" Make a backup before overwriting a file.
" The backup is removed after the file was successfully written,
" unless the 'backup' option is also on.
set writebackup

set backupdir-=.
set directory-=.

" Restores undo history from the same file on buffer read.
if has('persistent_undo')
  set undofile
  let &g:undodir=&directory
endif
" }}}

" === Appearance ======================================================== {{{1
" Colors.
if &term =~ "xterm-256color" || &term=~"screen-256color"
  " 256 colors.
  set t_Co=256
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
  " Change cursor shape.
  " let &t_SI = "\<ESC>]12;lightgreen\x7"
  " let &t_EI = "\<ESC>]12;white\x7"
  " Enable true color.
  if exists('+termguicolors')
    set termguicolors
  endif
  " Source my color settings.
  if $ITERM_PROFILE =~ "Magica.*"
    source ~/.vim/colors/my-landscape.vim
  elseif $ITERM_PROFILE =~ "Solarized.*"
    source ~/.vim/colors/my-solarized.vim
  else
    source ~/.vim/colors/my-hybrid.vim
  endif
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  " 16 colors.
  set t_Co=16
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
  source ~/.vim/colors/my-solarized.vim
elseif &term =~ "xterm-color"
  " 8 colors.
  set t_Co=8
  set t_Sf=^[[3%dm
  set t_Sb=^[[4%dm
  source ~/.vim/colors/my-solarized.vim
endif

" Disable italic/bold syntax (_*) on Markdown.
autocmd MyAutoCmd FileType markdown
      \ highlight! def link htmlItalic       Normal |
      \ highlight! def link htmlBold         Normal |
      \ highlight! def link htmlBoldItalic   Normal

" Enable colors for TeraTerm.
let s:is_teraterm = 0
if s:is_teraterm
  set term=builtin_linux
  set ttytype=builtin_linux
endif

" ------------------ * COLOR SETTINGS BEYOND THIS POINT. * ------------------

set ttyfast      " Fast terminal connection.
set number       " Print the line number in front of each line.
set scrolloff=7  " Minimal number of screen lines to keep above and below the cursor.

" Change the way text is displayed.
"   lastline  As much as possible of the last line in a window will be displayed.
"   uhex      Show unprintable characters hexadecimal as <xx> instead of using ^C and ~C.
set display& display+=uhex,lastline

" Window.
set splitbelow      " Splitting a window will put the new window below the current one.
set splitright      " Splitting a window will put the new window right of the current one.
set winwidth=20     " Minimal number of columns for the current window.
set winheight=1     " Minimal number of lines for the current window.
set previewheight=8 " Default height for a preview window.
set helpheight=12   " Minimal initial height of the help window when it is opened with the ':help' command.

" equalalways
"   ON  All the windows are automatically made the same size after
"       splitting or closing a window.
"   OFF Splitting a window will reduce the size of the current window
"       and leave the other windows the same.
"set noequalalways

" The screen will not be redrawn while executing macros, registers
" and other commands that have not been typed.
set lazyredraw

" Ttile.
" The title of the window will be set to the value of
" 'titlestring' (if it is not empty), or to:
" filename [+=-] (path) - VIM
set title
set titlelen=95
let &g:titlestring="
      \ %{expand('%:p:~:.')}%(%m%r%w%)
      \ %<\(%{".s:SID_PREFIX()."strwidthpart(
      \ fnamemodify(&filetype ==# 'vimfiler' ?
      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
      \ &columns-len(expand('%:p:.:~')))}\) - VIM"

function! s:strwidthpart(str, width) abort
  if a:width <= 0
    return ''
  endif
  let ret = a:str
  let width = s:wcswidth(a:str)
  while width > a:width
    let char = matchstr(ret, '.$')
    let ret = ret[: -1 - len(char)]
    let width -= s:wcswidth(char)
  endwhile
  return ret
endfunction

" Conceal/colorcolumn.
if v:version >= 703
  set conceallevel=2 concealcursor=niv
  " Show colorcolumn.
  if exists('+colorcolumn')
    set colorcolumn=80
  endif
  " Use builtin function.
  function! s:wcswidth(str) abort
    return strwidth(a:str)
  endfunction
else
  function! s:wcswidth(str) abort
    return len(a:str)
  endfunction
endif

" command-line.
set showcmd        " Show command on statusline.
set showmode       " Show mode on statusline.
set laststatus=2   " Display always statusline.
set cmdheight=2    " Number of screen lines to use for the command-line.
set cmdwinheight=7 " Maximum command-line window height.
set ruler          " Show the line and column number of the cursor position.

" Invisible chars.
set list
if s:is_windows
  set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
else
  set listchars=tab:▸\ ,trail:_,extends:»,precedes:«,nbsp:%
endif

" Soft wrap.
if exists('+breakindent')
  set wrap
  " Every wrapped line will continue visually indented (same amount of space
  " as the beginning of that line), thus preserving horizontal blocks of text.
  set breakindent
else
  set nowrap
endif
" Specify keys that move the cursor left/right to move to the previous/next line
" when the cursor is on the first/last character in the line.
set whichwrap+=b,s,<,>,~,[,]
" Wrap long lines at a character in 'breakat' rather than at the last character
" that fits on the screen.
set linebreak
" Specify characters that might cause a line break.
set breakat=\ \	;:,./!?
" String to put at the start of lines that have been wrapped.
let &showbreak = '> '

" Highlight current cursor line.
set cursorline
" Show onely cursor line on current window.
autocmd MyAutoCmd WinLeave * set nocursorline
autocmd MyAutoCmd BufEnter,WinEnter,BufRead * set cursorline

" Default statusline.
" (if lightline.vim is not installed)
" let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
"       \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
"       \ . "%{expand('%:t:.')}"
"       \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
"       \ . "%{printf(' %5d/%d',line('.'),line('$'))}"

" Folding.
" set foldenable
" set foldmethod=expr
set foldmethod=marker
set foldcolumn=3
set foldnestmax=3
set fillchars=vert:\|
set commentstring=%s

" tabline.
" When the line with tab page labels will be displayed:
"   0: never
"   1: only if there are at least two tab pages
"   2: always
set showtabline=2

" View setting (:mkview).
set viewdir=$CACHE/vim_view
set viewoptions& viewoptions-=options viewoptions+=slash,unix
" }}}

" === Edit ==============================================================={{{1
" No beep and bells.
set noerrorbells
set vb t_vb=
set belloff=all

set viminfo='50,<1000,s100,\"50 " Settings for .viminfo.
set isfname-==                  " The characters included in file names and path names.
set virtualedit=block           " Allow virtual editing in Visual block mode.
set updatetime=1000             " CursorHold time.
set keywordprg=:help            " Program to use for the |K| command.
set spelllang=en_us             " Language(s) to do spell checking for.
set spelllang+=cjk              " Not spell checking Chinese, Japanese and other East Asian characters.
set report=0                    " Threshold for reporting number of lines changed. (0:always)
set nostartofline               " The cursor is kept in the same column (if possible) when move the cursor.
set switchbuf=useopen           " This option controls the behavior when switching between buffers.

" Each item allows a way to backspace over something:
"   indent  allow backspacing over autoindent
"   eol     allow backspacing over line breaks (join lines)
"   start   allow backspacing over the start of insert
set backspace=indent,eol,start

" Display another buffer when current buffer isn't saved.
set hidden

" Indent.
set autoindent
set smartindent
set cindent

" <Tab>/spaces.
set tabstop=2     " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2  " Number of spaces to use for each step of (auto)indent.
set softtabstop=2 " Number of spaces that <Tab>/<BS> uses while editing.
set smarttab      " A <Tab> in front of a line inserts blanks according to 'shiftwidth'.
set expandtab     " Use spaces when <Tab> is inserted.
set shiftround    " Round indent to multiple of 'shiftwidth'.

" Bracket match paren.
set showmatch      " When a bracket is inserted, briefly jump to the matching one.
set matchtime=3    " The time to show the match.
set cpoptions-=m   " A showmatch will wait half a second or until a character is typed.
set matchpairs& matchpairs+=<:>

" Search.
set ignorecase
set smartcase
set wrapscan                     " Searches wrap around the end of the file.
set hlsearch                     " Highlight all matches.
set noincsearch                  " Disable incremental search.

" Grep(:grep).
" Program to use for the :grep command.
"   -i  Ignorecase
"   -n  Show line number.
"   -H  Show file name.
"   -E  Use extended regular expression.
"   $*  The placeholder.
set grepprg=grep\ -inHE\ $*\ /dev/null

" command-line completion
set infercase       " Ignorecase of match for keyword completion.
set wildmenu        " command-line completion operates in an enhanced mode.
set wildchar=<tab>  " Character you have to type to start wildcard expansion.
set wildmode=list,list:longest,full " Completion mode.
set wildoptions=tagfile             " Change how command line completion is done.
set complete& complete+=k           " Scan targets for completion.(k:dictionary) (default: .,w,b,u,t,i)
set completeopt=menuone             " Completion type. (menu/menuone/longest/preview)
set pumheight=20                    " The maximum number of items to show in the popup menu.
set history=1000                    " The number of command-line history.

" Set a priority between files with almost the same name.
" If there are multiple matches, those files with an extension
" that is in the 'suffixes' option are ignored.
set suffixes=.bk,.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Tags.
" Show both the tag name and a tidied-up form of the search pattern
" (if there is one) as possible matches.
set showfulltag
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

" autoread
" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread
" Check more closely than autoread.
autocmd MyAutoCmd WinEnter * checktime

" modeline.
" 1.If not include extraneous chars at the end of line.
"   # vim: ft=sh sw=4 sts=4 ts=4 et
" 2.If include extraneous chars at the end of line.
"   /* vim: set ft=c sw=4 sts=4 ts=4 et: */
" (default: 5)
set modeline

" Enable clipboard.
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

" Enable the mouse on a terminal.
" http://yskwkzhr.blogspot.jp/2013/02/use-mouse-on-terminal-vim.html
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    " Enable mouse on screen.
    set ttymouse=xterm2
  endif
endif

" Disable paste mode and update diff automatically.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Use autofmt.
if exists('autofmt#japanese#formatexpr')
  set formatexpr=autofmt#japanese#formatexpr()
endif
" }}}

" === Misc 1 ============================================================ {{{1
" Remove trailing whitespace when the buffer is saved.
autocmd MyAutoCmd BufWritePre * :%s/\s\+$//ge
" Convert tabs to spaces when the buffer is saved.
"autocmd MyAutoCmd  BufWritePre * :%s/\t/  /ge

" Restore cursor position.
" vimrc_example.vim is enable by default on Kaoriya.
autocmd MyAutoCmd BufReadPost * call <SID>restore_cursor_position()
function! s:restore_cursor_position() abort
  let bt = &buftype
  let ft = &filetype
  if bt ==# 'nofile'
        \ || ft ==# 'gitcommit' || ft ==# 'git-status' || ft ==# 'git-log'
        \ || ft ==# 'git-diff'  || ft ==# 'qf'         || ft ==# 'quickrun'
        \ || ft ==# 'qfreplace' || ft ==# 'ref'
    if has('kaoriya')
      normal! gg
      normal! 0
      echom 'Reset cursor position...'
    endif
    return
  elseif !has('kaoriya') && line("'\"") > 0 && line("'\"") <= line("$")
    normal! g`"
  endif
endfunction

" Restore search option when move windows.
" http://d.hatena.ne.jp/tyru/20140129/localize_search_options
autocmd MyAutoCmd WinLeave *
      \     let b:vimrc_pattern = @/
      \   | let b:vimrc_hlsearch = &hlsearch
autocmd MyAutoCmd WinEnter *
      \     let @/ = get(b:, 'vimrc_pattern', @/)
      \   | let &l:hlsearch = get(b:, 'vimrc_hlsearch', &l:hlsearch)

" Enable filetype detect/plugin/indent.
" filetype detection:ON  plugin:ON  indent:ON
autocmd MyAutoCmd FileType,Syntax,BufNewFile,BufNew,BufRead
      \ * call s:my_on_filetype()
function! s:my_on_filetype() abort
  if &l:filetype == '' && bufname('%') == ''
    return
  endif
  redir => filetype_out
  silent! filetype
  redir END
  if filetype_out =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction

" Open Quickfix window automatically.
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep,Sgrep call s:auto_qf_open()
function! s:auto_qf_open() abort
  if len(getqflist()) != 0
    execute 'HierUpdate'
    execute 'QuickfixStatusEnable'
    execute 'QuickfixsignsEnable'
    execute 'cwindow'
    execute 'redraw!'
  endif
endfunction

" Close unnecessary windows automatically.
autocmd MyAutoCmd WinEnter * call s:auto_qf_close()
function! s:auto_qf_close() abort
  if tabpagenr('$') > 1
    return
  endif
  for winnr in range(1, winnr('$'))
    let buftype = getwinvar(winnr, '&buftype')
    let ft = getwinvar(winnr, '&filetype')
    if buftype ==# 'quickfix' || ft ==# 'nerdtree' || ft ==# 'help'
          \ || ft ==# 'vimfiler' || ft ==# 'quickrun'
    else
      return
    endif
  endfor
  quitall
endfunction

" Show modeline immediately when input <ESC>.
"   http://gajumaru.ddo.jp/wordpress/?p=1076
"   http://gajumaru.ddo.jp/wordpress/?p=1101
"   http://yakinikunotare.boo.jp/orebase2/vim/dont_work_arrow_keys_in_insert_mode
"   https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ibus
"   https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese/ime-control/ctrl-hat
" set timeout timeoutlen=3000 ttimeoutlen=100
if !has('gui_running')
  set ttimeoutlen=10
  augroup MyFastEscapeAu
    autocmd!
    autocmd InsertEnter * set timeoutlen=500
    autocmd InsertLeave * set timeoutlen=1000
  augroup END
endif

" Set the default skeleton file.
augroup MySkeltonAu
  autocmd!
  autocmd BufNewFile .editorconfig 0r $HOME/.vim/my_templates/skel.editorconfig
  autocmd BufNewFile *.html 0r $HOME/.vim/my_templates/skel.html
  autocmd BufNewFile *.py 0r $HOME/.vim/my_templates/skel.py
  autocmd BufNewFile *.sh 0r $HOME/.vim/my_templates/skel.sh
  autocmd BufNewFile *.user.js 0r $HOME/.vim/my_templates/skel.user.js
augroup END
" }}}

" === Misc 2: FileType ==================================================={{{1
augroup MyAutoCmdEx
  autocmd!
  " TODO: .vim/ftplugin/after/xxx.vim
  " Set sw/sts/ts/et/tx/etc.
  " sw  : shiftwidth (インデント時に使用されるスペースの数)
  " sts : softtabstop (0でないなら、タブを入力時、その数値分だけ半角スペースを挿入)
  " ts  : tabstop (タブを画面で表示する際の幅)
  " et  : expandtab (有効時、タブを半角スペースとして挿入)
  " tw  : textwidth
  autocmd FileType gitcommit setlocal tw=72
  autocmd FileType make      setlocal noet
  autocmd FileType asp,html,jsp,perl,php,xml syntax sync minlines=500 maxlines=1000

  autocmd FileType diff,qf,qfreplace,quickrun,
        \git,gitv,gitcommit,git-status,git-log,git-diff
        \ setlocal nofoldenable nomodeline foldcolumn=0 foldlevel=0
augroup END
" }}}

" === Mappings 1: Edit ================================================== {{{1
" Enclose easily.
vnoremap { "zdi<C-V>{<C-R>z}<ESC>
vnoremap } "zdi<C-V>{<C-R>z}<ESC>
vnoremap [ "zdi<C-V>[<C-R>z]<ESC>
vnoremap ] "zdi<C-V>[<C-R>z]<ESC>
vnoremap ( "zdi<C-V>(<C-R>z)<ESC>
vnoremap ) "zdi<C-V>(<C-R>z)<ESC>
vnoremap " "zdi<C-V>"<C-R>z<C-V>"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" Indent.
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
xnoremap <Tab>   >
xnoremap <S-Tab> <
" }}}

" === Mappings 2: Move ================================================== {{{1
" Display lines downward/upward.
" Differs from j/k when lines wrap.
silent! nnoremap <unique> j gj
silent! nnoremap <unique> k gk
nnoremap <Down> j
nnoremap <Up>   k

" Move fast!
nnoremap H  ^
xnoremap H  ^
nnoremap L  $
xnoremap L  $h

nnoremap 1  0
nnoremap 0  ^
nnoremap 9  $

nnoremap (  %
nnoremap )  %

" Go to [count] older/newer position in change list.
" g; <-> g,
nnoremap <C-g> g;
" To the position where the last change was made.
nnoremap gb    `.zz
" To the position where the cursor was the last time when Insert mode was stopped.
nnoremap gB    `^zz

" Select the last edit text.
nnoremap <silent> <Leader>gc :<C-u>normal! `[v`]<CR>
vnoremap <silent> <Leader>gc :<C-u>normal! `[v`]<CR>
onoremap <silent> <Leader>gc :<C-u>normal! `[v`]<CR>
" }}}

" === Mappings 3: Buffer/Window/Tab ===================================== {{{1
" --- Buffer. ---
" Previous buffer.
nnoremap <silent> <F2> :<C-u>bp<CR>
" Next buffer.
nnoremap <silent> <F3> :<C-u>bn<CR>
" Delete buffer.
nnoremap <silent> <F4> :<C-u>call <SID>delete_buf()<CR>
function! s:delete_buf() abort
  let win_num = winnr('$')
  let prebuf = bufnr('#')
  bnext
  if bufnr('#') > 0 && bufnr('#') != prebuf && bufnr('%') != bufnr('#')
    bdelete #
  else
    echo 'Last buffer!'
  endif
  if win_num == 1 && tabpagenr('$') > 1
    tabclose
  endif
endfunction

" --- Window. ---
" Disable 'q' recording to prevent malfunction.
nnoremap <silent><expr> q &readonly \|\| !&modifiable ? <SID>smart_close() : ""
nnoremap Q q

" q/ESC close temporary window.
autocmd MyAutoCmd FileType help,gitcommit,git-status,git-log,git-diff,
      \qf,quickrun,qfreplace,ref,vcs-commit,vcs-status
      \ nnoremap <buffer><silent> q :<C-u>call <SID>smart_close()<CR>
autocmd MyAutoCmd FileType help,qf,quickrun,ref
      \ nnoremap <buffer><silent> <ESC> :<C-u>call <SID>smart_close()<CR>

autocmd MyAutoCmd FileType *
      \ if (&readonly || !&modifiable) && &ft !=# 'vimfiler' && &ft !=# 'unite' |
      \   nnoremap <buffer><silent> Q :<C-u>call <SID>smart_close()<CR> |
      \ endif
autocmd MyAutoCmd FileType *
      \ if (&readonly || !&modifiable)
      \ && &ft !=# 'vimfiler' && &ft !=# 'unite' && !hasmapto('<ESC>', 'n') |
      \   nnoremap <buffer><silent> <ESC> :<C-u>call <SID>smart_close()<CR> |
      \ endif

function! s:smart_close() abort
  if winnr('$') != 1
    close
  elseif &readonly || !&modifiable
    quitall
  endif
endfunction

" --- Tab pages. ---
set <C-Right>=[1;5C
set <C-Left>=[1;5D
" map  [1;5D <C-Left>
" map  [1;5C <C-Right>
" map! [1;5D <C-left>
" map! [1;5C <C-Right>
nnoremap [Tab]    <Nop>
nmap     <C-t>    [Tab]
nnoremap <silent> [Tab]n    :<C-u>tabnew<CR>
nnoremap <silent> [Tab]c    :<C-u>tabclose<CR>
nnoremap <silent> [Tab]o    :<C-u>tabonly<CR>
nnoremap <silent> <C-Right> :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
nnoremap <silent> <C-Left>  :<C-u>tabp<CR>
command! -nargs=* -complete=file E tabnew <args>

silent! nunmap <Tab><Tab>
nnoremap <silent> <Tab>   :call <SID>NextTabWindowBuffer()<CR>
nnoremap <silent> <S-Tab> :call <SID>PreviousTabWindowBuffer()<CR>

function! s:NextWindow() abort
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction

function! s:NextTabWindowBuffer() abort
  if tabpagenr('$') > 1
    tabnext
  elseif winnr("$") > 1
    wincmd w
  else
    bnext
  endif
endfunction

function! s:PreviousTabWindowBuffer() abort
  if tabpagenr('$') > 1
    tabprevious
  elseif winnr("$") > 1
    wincmd W
  else
    bprevious
  endif
endfunction

command! SplitNicely call s:split_nicely()
function! s:split_nicely() abort
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
" }}}

" === Mappings 4: Tags/Quickfix/Folding ================================= {{{1
" --- tags. ---
nnoremap [Tag]     <Nop>
nmap     <Leader>t [Tag]
" Jump to the definition of the keyword under the cursor.
nnoremap <silent> [Tag]t  <C-]>
" Jump to newer entry in tag stack.
nnoremap <silent> [Tag]n  :<C-u>tag<CR>
" Jump to older entry in tag stack.
nnoremap <silent> [Tag]p  :<C-u>pop<CR>

" --- QuickFix. ---
" Toggle QuickFix window.
function! s:toggle_qf_window() abort
  for bufnr in range(1,  winnr('$'))
    if getwinvar(bufnr,  '&buftype') ==# 'quickfix'
      execute 'ccl'
      return
    endif
  endfor
  execute 'botright cw'
endfunction
nnoremap <silent> cw :call <SID>toggle_qf_window()<CR>
" Quickfix next/previous.
nnoremap <buffer> ]q :cnext<CR>
nnoremap <buffer> [q :cprevious<CR>

" --- Folding. ---
" Move to the start/end of the current open fold.
nnoremap zh [z
nnoremap zl ]z
" If press 'l' on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press 'l' on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
" Close foldings smartly.
nnoremap <silent> z<Space> :<C-u>call <SID>smart_foldcloser()<CR>
function! s:smart_foldcloser() abort
  if foldlevel('.') == 0
    norm! zM
    return
  endif
  let foldc_lnum = foldclosed('.')
  norm! zc
  if foldc_lnum == -1
    return
  endif
  if foldclosed('.') != foldc_lnum
    return
  endif
  norm! zM
endfunction
" }}}

" === Mappings 5: Search/Yank/Replace =================================== {{{1
" --- Search ---
" Move to a search result and redraw cursor line at center of window.
silent! nnoremap <silent><unique> n  nzzzv
silent! nnoremap <silent><unique> N  Nzzzv
silent! nnoremap <silent><unique> *  *Nzzzv
silent! nnoremap <silent><unique> #  #Nzzzv
silent! nnoremap <silent><unique> g* g*Nzzzv
silent! nnoremap <silent><unique> g# g#Nzzzv

" Search with very magic.
" http://deris.hatenablog.jp/entry/2013/05/15/024932
nnoremap / /\v

" Search the selected word on Visual mode.
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" --- Yank/Paste ---
" Yank with clipboard on Visual Mode.
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif

" Yank the word under the cursor.
nnoremap zy viwy
" Replace the word under the cursor with yanked item.
nnoremap zp viwpviwy

" Yank and Replace repeatedly.
vnoremap zy "zy
vnoremap zp "zp

" Yank until the beginning of line.
nnoremap y0 y^
" Yank until the end of line.
nnoremap Y  y$
nnoremap y9 y$

" Paste insert at the bigining of the selected text on Visual mode.
vnoremap <C-p> I<C-r>"<ESC><ESC>

" --- Rplace ---
" Rplace with the word under the cursor.
" 1.置換後文字列をヤンク  2.置換元単語にカーソルを移動
" 3.<C-s>  4.置換後文字列を編集して実行
" (ヤンクした文字列を貼り付け : <C-r>")
" (クリップボードから貼り付け : <C-r>+)
nnoremap <expr> <C-s> ':%s/' . expand('<cword>') . '/<C-r>"/gc<Left><Left>'
"nnoremap <expr> ss* ':%s/\<' . expand('<cword>') . '\>/<C-r>"/g'

" Rplace with selected word on Visual mode.
" 1.置換後文字列をヤンク  2.置換元文字列を選択(Visual mode)
" 3.<C-s>  4.置換後文字列を編集して実行
vnoremap <C-s> "vy:%s/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR>/<C-r>+/gc<Left><Left>
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

" Replace in selected area on Visual mode.
" 1.置換元文字列をヤンク  2.置換範囲を選択
" 3.sv  4.置換後文字列を入力して実行
vnoremap sv "vy:%s/\%V<C-r>+//gc<Left><Left><Left><Left>
" }}}

" === Mappings 6: Insert mode/Command-line mode ========================= {{{1
" --- Insert mode keymappings. ---
inoremap jj       <ESC>
inoremap っj      <ESC>
inoremap j<Space> j
inoremap <C-a>    <HOME>
inoremap <C-e>    <END>
" C-hjkl move cursor. (Mac use Karabiner)
if !has('mac')
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>
endif
" Insert <Tab>.
inoremap <C-t>  <C-v><Tab>
" Delete backward char.
"  Set 'stty -ixoff -ixon' in .bashrc/.zshc because <C-q>/<C-s> is used in terminal.
"  http://d.hatena.ne.jp/ksmemo/20110214/p1
"  http://www.akamoz.jp/you/uni/shellscript.htm
inoremap <C-q> <ESC>xi
" Undoable C-u>/<C-w>.
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
" Paste.(Windows-compatible)
" inoremap <C-v> <ESC>"*pa

" Print date-time.
inoremap <expr> <Leader>df strftime('%Y/%m/%d %H:%M:%S')
inoremap <expr> <Leader>dd strftime('%Y/%m/%d')
inoremap <expr> <Leader>dt strftime('%H:%M:%S')

" Print separator.
inoremap <expr> <Leader>r* repeat('*', 79 - col('.'))
inoremap <expr> <Leader>r# repeat('#', 79 - col('.'))
inoremap <expr> <Leader>r+ repeat('+', 79 - col('.'))
inoremap <expr> <Leader>r- repeat('-', 79 - col('.'))
inoremap <expr> <Leader>r= repeat('=', 79 - col('.'))

" Close bracket automatically.
function! s:auto_close_bracket() abort
  " inoremap <silent> <buffer> { {}<Left>
  " inoremap <silent> <buffer> [ []<Left>
  " inoremap <silent> <buffer> ( ()<Left>
  " inoremap <silent> <buffer> " ""<Left>
  " inoremap <silent> <buffer> ' ''<Left>
  inoremap <silent> <buffer> () ()<Left>
  inoremap <silent> <buffer> [] []<Left>
  inoremap <silent> <buffer> {} {}<Left>
  inoremap <silent> <buffer> "" ""<Left>
  inoremap <silent> <buffer> '' ''<Left>
  inoremap <silent> <buffer> <> <><Left>
endfunction
autocmd MyAutoCmd FileType python,coffee,javascript,html,vim,ruby,sh,zsh,text
      \ call s:auto_close_bracket()

" --- Command-line mode keymappings. ---
" Move cursor.
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" Delete a char.
cnoremap <C-d> <Del>
" Delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" History.
cnoremap <C-n>  <Down>
cnoremap <C-p>  <Up>
cnoremap <Down> <C-n>
cnoremap <Up>   <C-p>
" Paste.
cnoremap <C-y>  <C-r>*
" Exit.
cnoremap <C-g>  <C-c>
" Paste.(Windows-compatible)
cnoremap <C-v> <C-r>+
" Write forcely with sudo.
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>
" }}}

" === Mappings 7: Misc ================================================== {{{1
" <ESC><ESC>
"  - Clear search highlight.
"  - Clear vim-hier.
nnoremap <silent><ESC><ESC> :<C-u>nohlsearch<CR>:HierClear<CR>:redraw!<CR><ESC>

" Disable ZZ.
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Disable <C-o> for screen/tmux.
nnoremap <C-o>     <Nop>
nnoremap <Space>o  <C-o>

" Increment.
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nmap +     <SID>(increment)
nmap -     <SID>(decrement)
nnoremap <silent> <SID>(increment) :AddNumbers  1<CR>
nnoremap <silent> <SID>(decrement) :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num) abort
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num . next_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif
  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction
" }}}

" === Mappings 8: Mac =================================================== {{{1
if s:is_mac
  " --- Mappings ---
  " Open the current file with Marked.app.
  nnoremap <Leader>om :<C-u>silent !open -a Marked.app '%:p'<cr>:redraw!<cr>

  " --- Commands ---
  " Open the current file with Chrome.
  command! -nargs=0 -bang ObCurrent silent<bang> call s:open_browser()
  function! s:open_browser() abort
    try
      execute '!open -a Google\ Chrome %:p'
    finally
      execute 'redraw!'
    endtry
  endfunction
endif
" }}}

" === Commands ==========================================================={{{1
" Reload.
command! -nargs=0 -bang Reload call s:reload_file('<bang>')
function! s:reload_file(bang) abort
  if !empty(a:bang)
    EditorConfigReload
  endif
  IndentLinesReset
  syntax sync fromstart
endfunction

" Manpage.
command! -nargs=* Man delcommand Man | runtime ftplugin/man.vim | Man <args>

" Toggle paste mode (:Pt).
command! Pt setlocal paste! | setlocal paste?

" Rename a file (:Rename).
command! -nargs=1 -complete=file Rename file <args>|call delete(expand('#'))

" Show all mappings (:AllMaps/:AllMaps <buffer>/:verbose AllMpas).
command! -nargs=* -complete=mapping AllMaps
      \ map <args> | map! <args> | lmap <args>

" Leave the screnn after exit vim or run shell. (alternate screen)
command! -nargs=0 QUIT  set t_te= t_ti= | quit | set t_te& t_ti&<CR>
command! -nargs=0 SHELL set t_te= t_ti= | sh   | set t_te& t_ti&<CR>

" Clear undo history (:ClearUndo/:W).
command! -bar ClearUndo  call <SID>clear_undo()
command! -bar -bang -nargs=? -complete=file W call <SID>clear_undo() | update<bang> <args>
function! s:clear_undo() abort
  let old_undolevels = &undolevels
  setlocal undolevels=-1
  execute "normal! a \<BS>\<ESC>"
  let &l:undolevels = old_undolevels
  echom strftime('[%Y-%m-%d %H:%M:%S]').' Clear undo!'
endfunction

" Change directory (:CD, :CdCurrent).
" http://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
if !has('kaoriya')
  command! -nargs=0 CdCurrent CD
endif
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang) abort
  let dir = a:directory
  if dir == ''
    let filetype = getbufvar(bufnr('%'), '&filetype')
    if filetype ==# 'vimfiler'
      let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
    elseif filetype ==# 'vimshell'
      let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
    else
      let dir = isdirectory(bufname('%')) ?
            \ bufname('%') : fnamemodify(bufname('%'), ':p:h')
    endif
  endif
  execute 'lcd' fnameescape(dir)
  if a:bang == ''
    pwd
  endif
endfunction

" Diff (:VDsplit, :Undiff, :DiffOrig).
if !has('kaoriya')
  " Diff the current file from the specified file.
  command! -nargs=1 -complete=file VDsplit vertical diffsplit <args>
  " Disable diff mode.(or :diffoff)
  command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap
endif
" DiffOrig is defined in vimrc_example.vim.
" its file is enable by default on Kaoriya.
if exists(':DiffOrig') != 2
  " Diff the current file from last save.
  command! DiffOrig vert new | setlocal bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

" Get syntax information (:SyntaxInfo).
" http://cohama.hateblo.jp/entry/2013/08/11/020849
command! SyntaxInfo call s:get_syn_info()
function! s:get_syn_id(transparent) abort
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid) abort
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info() abort
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction

" Print separator.
" :Separator 78, '='
" :Line -
command! -nargs=+ Separator call Separator(<args>)
command! -nargs=1 Line execute 'normal! i'.(repeat(<f-args>, 79 - col('.')))
function! Separator(width, sep, ...) abort
  let register = v:register != '' ? v:register : '"'
  let title = eval('@'.register)
  if len(title) == 0 || len(title) > 40 || len(getline(line('.'))) > 40
    return
  endif
  let title = ' '.title.' '
  let len_title = strlen(substitute(title, ".", "x", "g"))
  let start = a:0 >= 1 ? a:1 : repeat(a:sep, 3)
  let start = '" '.start
  let end = a:0 >= 2 ? a:2 : '{{{' " }}}
  let repeat_sep = a:width - len(start) - len_title - len(end)
  let line = start.title.repeat(a:sep, repeat_sep).end
  execute 'normal! 0d$'
  execute 'normal! i'.line
endfunction

" Format for Json file.(:Json, :Jq)
" http://qiita.com/tomoemon/items/cc29b414a63e08cd4f89
command! -nargs=0 JsonFormat execute '%!python -m json.tool'
  \ | execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'
  \ | %s/ \+$//ge
  \ | setlocal ft=javascript
  \ | 1
command! -bar -nargs=? Jq  call s:jq(<f-args>)
function! s:jq(...)
  execute '%!jq' (a:0 == 0 ? '.' : a:1)
endfunction

" echo-sd (:EchoSd xxxx).
" https://gist.github.com/yoshikaw/5693185
if executable('echo-sd')
  command! -nargs=* -range -bang EchoSd call s:echo_sd(<bang>0, <q-args>)
  function! s:echo_sd(bang, ...) abort
    let tmp = @@
    silent normal gvy
    let target = a:bang ? "'<,'>" : ''
    let selected = map(split(substitute(@@, '[\t]\+', '', 'g'), '[\n]'), 'shellescape(v:val, 1)')
    execute target . "!echo-sd" join(a:000, ' ') join(selected, ' ')
    let @@ = tmp
  endfunction
endif

" Change enc.
command! -bang -bar -complete=file -nargs=? Utf8      edit<bang> ++enc=utf-8       <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932     edit<bang> ++enc=cp932       <args>
command! -bang -bar -complete=file -nargs=? Euc       edit<bang> ++enc=euc-jp      <args>
command! -bang -bar -complete=file -nargs=? Utf16     edit<bang> ++enc=ucs-2le     <args>
command! -bang -bar -complete=file -nargs=? Utf16be   edit<bang> ++enc=ucs-2       <args>
" Aliases.
command! -bang -bar -complete=file -nargs=? Jis     Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis    Cp932<bang>     <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang>     <args>

" Change fenc.
" *WARNING* Conversion can cause loss of information!
command! WUtf8      setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932     setlocal fenc=cp932
command! WEuc       setlocal fenc=euc-jp
command! WUtf16     setlocal fenc=ucs-2le
command! WUtf16be   setlocal fenc=ucs-2
" Aliases.
command! WJis       WIso2022jp
command! WSjis      WCp932
command! WUnicode   WUtf16

" Change ff.
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args>  | edit <args>
command! -bang -complete=file -nargs=? WMac
      \ write<bang> ++fileformat=mac <args>  | edit <args>
" }}}

" TODO
" Disable auto wrap.
autocmd MyAutoCmd FileType *
      \ if &l:textwidth >= 70 && &filetype !=# 'help' |
      \   setlocal textwidth=0 |
      \ endif

" TODO
" IndentLinesReset.
autocmd MyAutoCmd FileType *
      \ if exists(':IndentLinesReset') |
      \   if index(g:indentLine_fileTypeExclude, &ft) >= 0 |
      \     execute 'IndentLinesDisable' |
      \   else |
      \     execute 'IndentLinesReset' |
      \   endif |
      \ endif

set secure

" vim: fdm=marker:
