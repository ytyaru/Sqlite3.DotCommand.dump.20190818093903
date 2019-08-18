SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# SQL文にしてstdoutへ出力する
sqlite3 :memory: "create table T(C text);" "insert into T values('AAA');" ".dump"
# ファイルへ出力する
sqlite3 :memory: "create table T(C text);" "insert into T values('AAA');" ".dump" > dump.sql
cat dump.sql
# ドットコマンドにてファイル出力＆ファイル表示
sqlite3 :memory: \
"create table T(C text);" \
"insert into T values('AAA');" \
".output dump.sql" \
".dump" \
".output stdout" \
".shell cat dump.sql"

