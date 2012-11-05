" バッファ再読み込み時の多重ロードを抑制
if exists("b:did_ftplugin_tweetvim")
  finish
endif
let b:did_ftplugin_tweetvim=1

" 参考
" https://github.com/basyura/TweetVim
" https://gist.github.com/3665856

" ### マッピング
" 各種アクション
nnoremap <buffer>s                :<C-u>TweetVimSay<CR>
nnoremap <buffer>m                :<C-u>TweetVimMentions<CR>
nmap     <buffer>c                <Plug>(tweetvim_action_in_reply_to)
nnoremap <buffer>t                :<C-u>Unite tweetvim -no-start-insert -quick-match<CR>
nmap     <buffer><Leader>F        <Plug>(tweetvim_action_remove_favorite)
nmap     <buffer><Leader>d        <Plug>(tweetvim_action_remove_status)
" リロード
nmap     <buffer><Tab>            <Plug>(tweetvim_action_reload)
" ページの先頭に戻ったときにリロード
nmap     <buffer><silent>gg       gg<Plug>(tweetvim_action_reload)
" ページ移動を ff/bb から f/b に
nmap     <buffer>f                <Plug>(tweetvim_action_page_next)
nmap     <buffer>b                <Plug>(tweetvim_action_page_previous)
" favstar や web UI で表示
nnoremap <buffer><Leader><Leader> :<C-u>call <SID>tweetvim_favstar()<CR>
" ブラウザで対象ユーザのホームを開く
nnoremap <buffer><Leader>u        :<C-u>call <SID>tweetvim_open_home()<CR>
" 縦移動（カーソルを常に中央にする）
nnoremap <buffer><silent>j        :<C-u>call <SID>tweetvim_vertical_move("gj")<CR>zz
nnoremap <buffer><silent>k        :<C-u>call <SID>tweetvim_vertical_move("gk")<CR>zz
" 不要なマップを除去
nunmap   <buffer>ff
nunmap   <buffer>bb


" tweetvim バッファに移動したときに自動リロード
autocmd BufEnter * call <SID>tweetvim_reload()


" セパレータを飛ばして移動する
" ページの先頭や末尾でそれ以上 上/下 に移動しようとしたらページ移動する
function! s:tweetvim_vertical_move(cmd)
  execute "normal! ".a:cmd
  let end = line('$')
  while getline('.') =~# '^[-~]\+$' && line('.') != end
    execute "normal! ".a:cmd
  endwhile
  " 一番下まで来たら次のページに進む
  let line = line('.')
  if line == end
    call feedkeys("\<Plug>(tweetvim_action_page_next)")
  elseif line == 1
    call feedkeys("\<Plug>(tweetvim_action_page_previous)")
  endif
endfunction

" filetype が tweetvim ならツイートをリロード
function! s:tweetvim_reload()
  if &filetype ==# "tweetvim"
    call feedkeys("\<Plug>(tweetvim_action_reload)")
  endif
endfunction

" カーソル行のツイートをしたユーザの favstar を開く
function! s:tweetvim_favstar()
  let screen_name = matchstr(getline('.'),'^\s\zs\w\+')
  let path = empty(screen_name) ? "/me" : "/users/" . screen_name

  execute "OpenBrowser http://ja.favstar.fm" . path
endfunction

" カーソル下のユーザを favstar で開く
function! s:open_favstar()
  let username = expand('<cword>')
  if empty(username)
    OpenBrowser http://ja.favstar.fm/me
  else
    execute "OpenBrowser http://ja.favstar.fm/users/" . username
  endif
endfunction
command! Favstar call <SID>open_favstar()

" ツイートしたユーザのホームを開く
function! s:tweetvim_open_home()
  let username = expand('<cword>')
  if username =~# '^[a-zA-Z0-9_]\+$'
    execute "OpenBrowser https://twitter.com/" . username
  endif
endfunction


" advanced filter
" https://github.com/rhysd/tweetvim-advanced-filter
"let g:tweetvim_filters = ['advanced']
" 外部ファイルのフィルター設定を読み込む
"if filereadable($HOME.'/.tweetvimrc')
  "source $HOME/.tweetvimrc
"endif
