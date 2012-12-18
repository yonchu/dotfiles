#!/bin/bash

#
# vm_statコマンドを使用してメモリ使用率(%)を求める
#   精度は小数点第1位までとする
#
calculate_used_mem_vm_stat() {
    # vm_stat
    #  page size of 4096 bytes
    #  http://qz.tsugumi.org/man_vm_stat.html
    #  http://d.hatena.ne.jp/zariganitosh/20110617/free_memory
    #  https://discussionsjapan.apple.com/thread/10093439?start=0&tstart=0
    #  http://support.apple.com/kb/HT1342?viewlocale=ja_JP&locale=ja_JP

    VM_STAT=$(vm_stat)
    PAGES_FREE=$(echo "$VM_STAT" | awk '/Pages free/ {print $3}' | tr -d '.')
    PAGES_ACTIVE=$(echo "$VM_STAT" | awk '/Pages active/ {print $3}' | tr -d '.')
    PAGES_INACTIVE=$(echo "$VM_STAT" | awk '/Pages inactive/ {print $3}' | tr -d '.')
    PAGES_SPECULATIVE=$(echo "$VM_STAT" | awk '/Pages speculative/ {print $3}' | tr -d '.')
    PAGES_WIRED=$(echo "$VM_STAT" | awk '/Pages wired down/ {print $4}' | tr -d '.')

    # 空きメモリ
    FREE_MEM=$(($PAGES_FREE + $PAGES_SPECULATIVE))

    # 使用中メモリ
    USED_MEM=$(($PAGES_ACTIVE + $PAGES_INACTIVE + $PAGES_WIRED))

    # 合計
    TOTAL_MEM=$(($FREE_MEM + $USED_MEM))


    # 使用中メモリ(%)
    #  小数点第1位まで求めて後から小数点文字(ドット)を挿入
    USED_MEM_PERCENT=$(echo "$(($USED_MEM * 1000 / $TOTAL_MEM))" | sed -e 's/\(.*\)\([0-9]\)/\1.\2/' -e 's/^\./0./')
    echo "${USED_MEM_PERCENT}"

    return 0
}

#
# freeコマンドを使用してメモリ使用率(%)を求める
#   精度は小数点第1位までとする
#
calculate_used_mem_free() {
    FREE=$(free)

    # 空きメモリ
    FREE_MEM=$(echo "$FREE" | awk '/-\/\+ buffers\/cache/ {print $4}')

    # 使用中メモリ
    USED_MEM=$(echo "$FREE" | awk '/-\/\+ buffers\/cache/ {print $3}')

    # 合計
    TOTAL_MEM=$(($FREE_MEM + $USED_MEM))


    # 使用中メモリ(%)
    #  小数点第1位まで求めて後から小数点文字(ドット)を挿入
    USED_MEM_PERCENT=$(echo "$(($USED_MEM * 1000 / $TOTAL_MEM))" | sed -e 's/\(.*\)\([0-9]\)/\1.\2/' -e 's/^\./0./')
    echo "${USED_MEM_PERCENT}"

    return 0
}


# Debug
debug() {
    if [ "$DEBUG" = "yes" ]; then
        echo "PAGES_FREE: $PAGES_FREE pages"
        echo "PAGES_FREE: $(($PAGES_FREE * 4096 / 1024 / 1024 )) MB"
        echo "PAGES_ACTIVE: $PAGES_ACTIVE pages"
        echo "PAGES_ACTIVE: $(($PAGES_ACTIVE * 4096 / 1024 / 1024)) MB"
        echo "PAGES_INACTIVE: $PAGES_INACTIVE pages"
        echo "PAGES_INACTIVE: $(($PAGES_INACTIVE * 4096 / 1024 / 1024)) MB"
        echo "PAGES_SPECULATIVE: $PAGES_SPECULATIVE pages"
        echo "PAGES_SPECULATIVE: $(($PAGES_SPECULATIVE * 4096 / 1024 / 1024 )) MB"
        echo "PAGES_WIRED: $PAGES_WIRED pages"
        echo "PAGES_WIRED: $(($PAGES_WIRED * 4096 / 1024 / 1024)) MB"
        echo "FREE_MEM: $FREE_MEM pages"
        echo "FREE_MEM: $(($FREE_MEM * 4096 / 1024 / 1024)) MB"
        echo "USED_MEM: $USED_MEM pages"
        echo "USED_MEM: $(($USED_MEM * 4096 / 1024 / 1024)) MB"
        echo "TOTAL_MEM: $TOTAL_MEM pages"
        echo "TOTAL_MEM: $(($TOTAL_MEM * 4096 / 1024 / 1024)) MB"
        echo "---------------"
        # 搭載メモリ(理論値): 8GBの場合
        echo "TOTAL_MEM: $((8 * 1024)) MB (Theoretical value)"
        echo "---------------"
        echo "USED_MEM: $(($USED_MEM * 1000 / $TOTAL_MEM)) %"
    fi
    return 0
}

# Main
if type vm_stat > /dev/null 2>&1; then
    calculate_used_mem_vm_stat || exit 1
elif type free > /dev/null 2>&1; then
    calculate_used_mem_free || exit 1
else
    exit 1
fi

exit 0

