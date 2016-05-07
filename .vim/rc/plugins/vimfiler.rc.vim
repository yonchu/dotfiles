" === Introduction === {{{
" Normal mode default mappings.
" -------------------------------------
"   <Tab>            switch to another vimfiler
"   j                loop cursor down
"   k                loop cursor up
"   gg               cursor top
"   <C-l>            redraw screen
"   <Space>          toggle mark current line
"   <S-LeftMouse>    toggle mark current line
"   <S-Space>        toggle mark current line up
"   *                toggle mark all lines
"   #                mark similar lines
"   U                clear mark all lines
"   c                copy file
"   m                move file
"   d                delete file
"   Cc               clipboard copy file
"   Cm               clipboard move file
"   Cp               clipboard paste
"   r                rename file
"   K                make directory
"   N                new file
"   <Enter>          cd or edit
"   o                expand or edit
"   l                smart l
"   x                execute system associated
"   h                smart h
"   L                switch to drive
"   ~                switch to home directory
"   \                switch to root directory
"   &                switch to project directory
"   <C-j>            switch to history directory
"   <BS>             switch to parent directory
"   .                toggle visible ignore files
"   H                popup shell
"   e                edit file
"   E                split edit file
"   B                edit binary file
"   ge               execute external filer
"   <RightMouse>     execute external filer
"   !                execute shell command
"   q                hide
"   Q                exit
"   -                close
"   g?               help
"   v                preview file
"   O                sync with current vimfiler
"   go               open file in another vimfiler
"   <C-g>            print filename
"   g<C-g>           toggle maximize window
"   yy               yank full path
"   M                set current mask
"   gr               grep
"   gf               find
"   S                select sort type
"   <C-v>            switch vim buffer mode
"   gc               cd vim current dir
"   gs               toggle safe mode
"   gS               toggle simple mode
"   a                choose action
"   Y                pushd
"   P                popd
"   t                expand tree
"   T                expand tree recursive
"   I                cd input directory
"   <2-LeftMouse>    double click
"   gj               jump last child
"   gk               jump first child
"
"   Visual mode mappings.
" -------------------------------------
"   <Space>          <Plug>(vimfiler toggle mark selected lines
" }}}

" OS flags.
let is_windows = has('win16') || has('win32') || has('win64')
let is_cygwin = has('win32unix')
let is_mac = !is_windows && !is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \ || (!executable('xdg-open') && system('uname') =~? '^darwin'))

" Basic Settings.
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern      = '^\%(\.git\|\.svn\)$'
let g:vimfiler_time_format         = '%Y/%m/%d %H:%M:%S'

" Profile Settings.
call vimfiler#custom#profile('default', 'context', {
      \ 'safe'       : 1,
      \ 'auto_expand': 1,
      \ 'edit_action': 'tabopen',
      \ 'parent'     : 1,
      \ 'status'     : 1,
      \ })

" Drives.
let g:vimfiler_detect_drives = is_windows ? [
      \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
      \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/'] :
      \ split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n') +
      \ split(glob('/Users/*'), '\n')

" SendTo menus.
" %p : full path
" %d : current directory
" %f : filename
" %F : filename removed extensions
" %* : filenames
" %# : filenames fullpath
let g:vimfiler_sendto = {
      \ 'unzip'   : 'unzip %f',
      \ 'zip'     : 'zip -r %F.zip %*',
      \ 'Inkscape': 'inkspace',
      \ 'GIMP'    : 'gimp %*',
      \ 'gedit'   : 'gedit',
      \ }

" Icons.
if is_windows
  " Use trashbox.
  let g:unite_kind_file_use_trashbox = 1
else
  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = '-'
  " let g:vimfiler_readonly_file_icon = 'X'
  " let g:vimfiler_marked_file_icon = '*'
  let g:vimfiler_readonly_file_icon = '✗'
  let g:vimfiler_marked_file_icon = '✓'
endif

" QuickLook.
let g:vimfiler_quick_look_command =
      \ is_windows ? 'maComfort.exe -ql' :
      \ is_mac     ? 'qlmanage -p'       : 'gloobus-preview'

" Local settings.
autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() abort
  call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
  call vimfiler#set_execute_file('txt', 'vim')
  call vimfiler#set_execute_file('pdf', 'zathura')

  nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
  nmap <buffer> p     <Plug>(vimfiler_quick_look)
  nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)
  nmap <buffer> o     <Plug>(vimfiler_expand_tree)
  nmap <buffer> <C-c> <Plug>(vimfiler_close)

  " Unite.
  nnoremap <silent><buffer> J
        \ <C-u>:Unite -buffer-name=files -default-action=lcd directory_mru<CR>

  " Migemo search.
  if !empty(unite#get_filters('matcher_migemo'))
    nnoremap <silent><buffer><expr> /  line('$') > 10000 ?  'g/' :
          \ ":\<C-u>Unite -buffer-name=search -start-insert line_migemo\<CR>"
  endif
endfunction
" }}}
