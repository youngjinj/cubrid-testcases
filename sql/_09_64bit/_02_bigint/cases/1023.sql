create class test_class (bigint_col bigint, datetime_col datetime, datetime_col1 datetime, timestamp_col timestamp);
insert into test_class(bigint_col, datetime_col, datetime_col1, timestamp_col) values (3600000, DATETIME '2001-01-01 00:00:00.000', DATETIME '2001-01-02 00:00:00.000', TIMESTAMP '01/01/2000 10:30:00');

update test_class set bigint_col = datetime_col;
update test_class set datetime_col = bigint_col;

drop class test_class;