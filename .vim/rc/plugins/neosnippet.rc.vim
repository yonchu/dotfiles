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

" smap <silent> L          <Plug>(neosnippet_jump_or_expand)
" xmap <silent> L          <Plug>(neosnippet_expand_target)
" smap <silent> K          <Plug>(neosnippet_expand_or_jump)
" xmap <silent> O          <Plug>(neosnippet_register_oneshot_snippet)

imap <C-s>      i_<Plug>(neosnippet_start_unite_snippet)
" inoremap <silent> (( <C-r>=neosnippet#anonymous('\left(${1}\right)${0}')<CR>
command! NeoSE NeoSnippetEdit -split

" vim: fdm=marker:
