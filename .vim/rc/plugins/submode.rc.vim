 " タイムアウト無効
 let g:submode_timeout = 0

 " タイムアウト時間 (ms)
 " let g:submode_timeoutlen = 10000

 " サブモードに入るためのキーマッピング定義
 "  submode#enter_with({submode}, {modes}, {options}, {lhs}, [{rhs}])
 "   {submode} : サブモード名
 "   {modes} : モートの種類 (複数指定可) (n = normal-mode、i = insert-mode ...)
 "   {options} : オプション (b = <buffer> e = <expr> ...)
 "   {lhs}
 "   [{rhs}]
 "
 " サブモード中のキーマッピング
 " submode#map({submode}, {modes}, {options}, {lhs}, {rhs})
 "
 " サブモードから抜ける : ESC

 call submode#enter_with('winsize', 'n', '', '<C-w><Space>')

 call submode#map('winsize', 'n', '', 'l', '<C-w>>')
 call submode#map('winsize', 'n', '', 'h', '<C-w><')
 call submode#map('winsize', 'n', '', 'k', '<C-w>-')
 call submode#map('winsize', 'n', '', 'j', '<C-w>+')
