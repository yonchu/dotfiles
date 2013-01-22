if exists("b:did_ftplugin_javascript")
  finish
endif
let b:did_ftplugin_javascript=1

"------------------------------------
" Simple-Javascript-Indenter
"------------------------------------
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1

"------------------------------------
" jscomplete-vim
"  オムニ補完
"------------------------------------
" DOMとMozilla関連とES6のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']
