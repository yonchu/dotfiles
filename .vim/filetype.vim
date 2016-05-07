" filetype.vim
"   :help new-filetype

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " applescript.
  autocmd BufRead,BufNewFile *.applescript,*.scpt setfiletype applescript
  " less.
  autocmd BufRead,BufNewFile *.less  setfiletype less
  " markdown.
  autocmd BufRead,BufNewFile *.md    setfiletype markdown
  " perl5.
  autocmd BufRead,BufNewfile *.p5    setfiletype perl
  " perl6.
  autocmd BufRead,BufNewfile *.p6    setfiletype perl6
  " scala.
  autocmd BufRead,BufNewFile *.scala setfiletype scala
  " typescript.
  autocmd BufRead,BufNewFile *.ts    setfiletype typescript
augroup END
