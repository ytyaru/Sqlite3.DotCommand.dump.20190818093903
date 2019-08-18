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

# 妥協案
sqlite3 :memory: \
".read create_tables.sql" \
".dump T1" > dump_t1_t3.sql
sqlite3 :memory: \
".read create_tables.sql" \
".dump T3" >> dump_t1_t3.sql
# 表示
cat dump_t1_t3.sql

# -------------------------------
# 以下、すべて失敗。以下のようなエラーが出る
# Usage: .dump ?--preserve-rowids? ?--newlines? ?LIKE-PATTERN?
# -------------------------------

sqlite3 :memory: \
".read create_tables.sql" \
".dump T1 T3" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1' 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
'.dump "T1" "T3"' > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump T1, T3" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1', 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1', 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1' AND 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1' && 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1' OR 'T3'" > dump_t1_t3.sql

sqlite3 :memory: \
".read create_tables.sql" \
".dump 'T1' || 'T3'" > dump_t1_t3.sql

