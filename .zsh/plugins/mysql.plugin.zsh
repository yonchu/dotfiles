#
# MySQL
#  データベース一覧 mysqlshow -uroot -p
#  --auto-rehash テーブル名/カラム名などの補完を有効
#  --no-auto-rehash テーブル名/カラム名などの補完を無効(SQL補完有効)
#

type mysql >/dev/null 2>&1 || { echo '...skip'; return; }

alias mysqlstatus='mysqladmin -u root -p ping'
alias mysqlr='mysql --auto-rehash'
alias mysqlnr='mysql --auto-rehash'
alias mysql_show_variables='mysql -uroot -p -e "show variables"'
alias mysql_show_user='mysql -uroot -p -e "select User, Host from mysql.user"'
alias mysql_show_mysql_tables='mysqlshow -uroot -p mysql'

