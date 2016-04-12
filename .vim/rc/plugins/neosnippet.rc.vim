"=== Introduction ========================================================={{{
"
"  neosnippet.rc.vim
"
"   neosnippet settings
"
"==========================================================================}}}

"   標準のスニペット群
"    ~/.vim/bundle/neosnippet/autoload/neosnippet/snippets

" ユーザー定義スニペット保存ディレクトリ
let g:neosnippet#snippets_directory =
      \ expand('~/dotfiles.local/.vim/snippets,').expand('~/.vim/snippets')

let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#enable_complete_done = 1
" let g:neosnippet#expand_word_boundary = 1

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"### キーマッピング
" Uniteでスニペットを表示
imap <C-s>  i_<Plug>(neosnippet_start_unite_snippet)

xmap <silent>o <Plug>(neosnippet_register_oneshot_snippet)

" ユーザ定義スニペットの編集
"   引数にfiletypeを渡すことで任意のファイルを編集可能
"   -runtime : Runtimeスニペットの編集
nnoremap <Space>nse :NeoSnippetEdit

" vim: fdm=marker:
