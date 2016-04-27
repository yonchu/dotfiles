" Disable timeout.
let g:submode_timeout = 0

" Define keymappings to enter submode.
"  submode#enter_with({submode}, {modes}, {options}, {lhs}, [{rhs}])
"   {submode} : Submode name.
"   {modes}   : Mode type. (sequence of letters like ni) (n = normal-mode、i = insert-mode ...)
"   {options} : Option. (b = <buffer> e = <expr> ...)
"   {lhs}
"   [{rhs}]
"
" Define keymappings during sumode.
" submode#map({submode}, {modes}, {options}, {lhs}, {rhs})
"
" End submode: ESC

" Resize window.
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')

call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')

call submode#map('winsize', 'n', '', 'l', '<C-w>>')
call submode#map('winsize', 'n', '', 'h', '<C-w><')
call submode#map('winsize', 'n', '', 'k', '<C-w>-')
call submode#map('winsize', 'n', '', 'j', '<C-w>+')

" Move Tab page.
call submode#enter_with('movetab', 'n', '', '<C-t>l', 'gt')
call submode#enter_with('movetab', 'n', '', '<C-t>h', 'gT')

call submode#map('movetab', 'n', '', 'l', 'gt')
call submode#map('movetab', 'n', '', 'h', 'gT')
