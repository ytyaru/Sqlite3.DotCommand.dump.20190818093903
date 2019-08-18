SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# テーブル作成するSQLファイルを作成する
echo "create table T1(C text);
insert into T1 values('AAA');
insert into T1 values('BBB');
create table T2(C text);
insert into T2 values('あああ');
insert into T2 values('いいい');
create table T3(C text);
insert into T3 values('アアア');
insert into T3 values('イイイ');" > create_tables.sql

# dumpする
sqlite3 :memory: \
".read create_tables.sql" \
".dump" > dump.sql
# 表示
cat dump.sql

# 1つのテーブルのみ
sqlite3 :memory: \
".read create_tables.sql" \
".dump T1" > dump_t1.sql

# `like`句パターンでテーブル名を指定
sqlite3 :memory: \
".read create_tables.sql" \
".dump '%2'" > dump_like.sql

