-- insert data  whith create range partition table on a int field and add a partition with maxvalue and then query all partitions and drop table

create table range_test(id int not null ,
			test_int int,
			test_char char(50),
			test_varchar varchar(2000),
			test_datetime timestamp,primary key(id,test_int))
PARTITION BY RANGE (test_int) (
    PARTITION p0 VALUES LESS THAN (10),
    PARTITION p1 VALUES LESS THAN (20),
    PARTITION p2 VALUES LESS THAN (30)
);
insert into range_test values (1,1,'aaa','aaa','2000-01-01 09:00:00');
insert into range_test values (2,2,'bbb','bbb','2000-01-02 09:00:00');
insert into range_test values (3,3,'ccc','ccc','2000-01-03 09:00:00');
insert into range_test values (4,11,'ddd','ddd','2000-02-01 09:00:00');
insert into range_test values (5,12,'eee','eee','2000-02-02 09:00:00');
insert into range_test values (6,13,'fff','fff','2000-02-03 09:00:00');
insert into range_test values (7,21,'ggg','ggg','2000-03-01 09:00:00');
insert into range_test values (8,22,'hhh','hhh','2000-03-02 09:00:00');
insert into range_test values (9,23,'iii','iii','2000-03-03 09:00:00');


ALTER TABLE range_test add partition (
partition p8 values less than maxvalue
);
insert into range_test values (11,50,'kkk','kkk','2000-05-01 09:00:00');
insert into range_test values (12,42,'lll','lll','2000-05-02 09:00:00');
select * from db_partition order by 3,4;

select * from range_test order by 1,2;

select * from range_test__p__p0 order by 1,2;
select * from range_test__p__p1 order by 1 ;
select * from range_test__p__p2 order by 1 ;

select * from range_test__p__p8 order by 1 ;

drop class range_test;
