#
# tmux
#

type tmux >/dev/null 2>&1 || { echo '...skip'; return; }

if type tmuxx >/dev/null 2>&1; then
    # pbcoopy対応のtmux
    alias tmx='tmuxx'
fi

alias tm='tmux'

# セッション名mainで新規作成
alias tmm='tmux new-session -s main'

# セッション名mainにアタッチ
alias tmam='tmux attach -t main'

# 最後に作成されたセッションにアタッチ
alias tma='tmux attach'

# 指定セッションをデタッチ後にアタッチ
alias tmad='tmux attach -d -t'

# セッションリストを表示
alias tml='tmux list-sessions'

# ウィンドウリストを表示
alias tmw='tmux list-window'

# クライアントリストを表示
alias tmc='tmux list-clients'

# ウィンドウタイトル変更
alias tmrw='tmux rename-window'

