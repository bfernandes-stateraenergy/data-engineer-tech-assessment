create table foo(id int primary key, bar text);
copy foo from '/data/foo.csv' with (format csv, header);
