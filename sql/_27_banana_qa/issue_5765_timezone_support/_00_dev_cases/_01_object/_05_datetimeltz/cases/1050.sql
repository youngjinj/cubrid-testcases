create class test_class (date_col date, time_col time, timestamp_col timestamp, datetime_col datetimeltz);

insert into test_class(datetime_col) values (datetimeltz '1-1-1 00:00:00.000');
insert into test_class(datetime_col) values (datetimeltz '0001-01-01 00:00:00.000');
insert into test_class(datetime_col) values (datetimeltz '1970-01-01 00:00:00.000');
insert into test_class(datetime_col) values (datetimeltz '1990-01-02 23:59:59.999');
insert into test_class(datetime_col) values (datetimeltz '2990-01-02 23:59:59.999');
insert into test_class(datetime_col) values (datetimeltz '1970-01-01 00:00:00');
insert into test_class(datetime_col) values (datetimeltz '1990-01-02 23:59:59');
insert into test_class(datetime_col) values (datetimeltz '2990-01-02 23:59:59');
insert into test_class(datetime_col) values (datetimeltz '01/01/1970 00:00:00.000');
insert into test_class(datetime_col) values (datetimeltz '01/02/1990 23:59:59.999');
insert into test_class(datetime_col) values (datetimeltz '01/02/2990 23:59:59.999');
insert into test_class(datetime_col) values (datetimeltz '01/01/1970 00:00:00');
insert into test_class(datetime_col) values (datetimeltz '01/02/1990 23:59:59');
insert into test_class(datetime_col) values (datetimeltz '01/02/2990 23:59:59');

select * from test_class where datetime_col between '1000-01-01 00:00:00.000' and '2000-01-01 00:00:00.000' order by 4;
select * from test_class where datetime_col between '3000-01-01 00:00:00.000' and '2000-01-01 00:00:00.000' order by 1;
select * from test_class where datetime_col not between '1000-01-01 00:00:00.000' and '2000-01-01 00:00:00.000' order by 4;

drop class test_class;