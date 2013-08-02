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

tmux_minimum_status() {
    if [[ -z $TMUX ]]; then
        return
    fi
    local is_minimum
    is_minimum=$(tmux showenv TMUX_MINIMUM_STATUS 2> /dev/null)
    if [[ -n $is_minimum ]]; then
        tmux setenv -u TMUX_MINIMUM_STATUS
        echo "Tmux Minimum Status: ON -> OFF"
    else
        tmux setenv TMUX_MINIMUM_STATUS 1
        echo "Tmux Minimum Status: OFF -> ON"
    fi
}
alias tmin='tmux_minimum_status'

