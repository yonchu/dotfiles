"=== Introduction ========================================================={{{
"
"  neosnippet.rc.vim
"
"   neosnippet settings
"
"   :NeoSnippetEdit [{options}] [filetype]
"
"==========================================================================}}}

" Builtin snippets.
" ~/.vim/bundle/neosnippet/autoload/neosnippet/snippets

let g:neosnippet#snippets_directory =
      \ expand('~/dotfiles.local/.vim/snippets,').expand('~/.vim/snippets')

let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#enable_complete_done = 1
" let g:neosnippet#expand_word_boundary = 1

imap <C-s>  i_<Plug>(neosnippet_start_unite_snippet)
xmap <silent>o <Plug>(neosnippet_register_oneshot_snippet)
" inoremap <silent> (( <C-r>=neosnippet#anonymous('\left(${1}\right)${0}')<CR>

command! NeoSE NeoSnippetEdit -split

" vim: fdm=marker:
