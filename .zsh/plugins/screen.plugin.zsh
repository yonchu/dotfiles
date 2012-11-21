#
# screen
#

type screen >/dev/null 2>&1 || { echo '...skip'; return; }

#
# alias
#  -U utf-8で起動(文字化けする場合に有効)
#  -ls or -list screenリスト
#  -S <name> セッション名指定
#  -r <name> アタッチ(再接続)
#  -D -RR 既存のセッションを強制デタッチして再接続(なければ新規作成)
#         再接続するならとりあえずこれ使っとけばOK
#
alias sc='screen -U'
alias sl='screen -ls'
alias ssm='screen -U -S main'
alias srm='screen -U -r main'
alias srr='screen -U -D -RR'


# SSHコマンドはscreenで実行
#  ssh_sc <server>
#
function ssh_sc(){
    local svr
    svr=$1
    shift
    ssh -t $svr screen -rx || screen -D -RR
}

# ssh先に対してscreenを起動してコマンドを実行
#  ssh_sc_cmd <server> <cmd>
#
function ssh_sc_cmd() {
    local svr
    svr=$1
    shift
    # $*のほうがいい？
    ssh $svr screen -d -m $@
}

