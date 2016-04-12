" コンフィグ設定
" 常に横分割
" markdownについて
"  htmlを開くデフォルトアプリケーションがブラウザの場合は
"   'outputter': 'multi:buffer:browser'
"  とすることでブラウザにて開くことができる
let g:quickrun_config = {
      \   '_': {
      \     'split': '',
      \     'runner' : 'vimproc',
      \     'runner/vimproc/updatetime' : 60,
      \     'outputter/buffer/close_on_empty' : 1,
      \   },
      \   'markdown': {
      \     'type': executable('markdown') ? 'markdown/markdown':
      \             executable('Markdown.pl') ? 'markdown/Markdown.pl':
      \             executable('kramdown') ? 'markdown/kramdown':
      \             executable('bluecloth') ? 'markdown/bluecloth':
      \             executable('redcarpet') ? 'markdown/redcarpet':
      \             executable('pandoc') ? 'markdown/pandoc':
      \             executable('markdown_py') ? 'markdown/markdown_py': '',
      \   },
      \   'markdown/markdown': {
      \     'split': winwidth(0) < winheight(0) * 3  ? "" : "vertical",
      \     'command': 'markdown',
      \     'cmdopt': '--html4tags',
      \     'args': '| tee /tmp/__markdown_for_quickrun.html; open -a Google\ Chrome /tmp/__markdown_for_quickrun.html',
      \     'outputter': 'multi:buffer',
      \   },
      \   'applescript': {
      \     'command' : 'osascript'
      \   },
      \ }

