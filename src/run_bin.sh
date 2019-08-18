SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo "create table Bins(B blob);
insert into Bins values(x'FF');
insert into Bins values(randomblob(16));
" > create_bin.sql

sqlite3 :memory: \
".read create_bin.sql" \
".dump" > dump_bin.sql

sqlite3 :memory: \
".read create_bin.sql" \
"select * from Bins;" \
".output dump_bin.sql" \
".dump" \
".output stdin"

cat dump_bin.sql

sqlite3 :memory: \
".read dump_bin.sql" \
"select * from Bins;" > a.bin

od -h a.bin

