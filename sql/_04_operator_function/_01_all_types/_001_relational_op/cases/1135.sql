--[er]test < operator with FLOAT and time type
create class tb ( 
	id int auto_increment primary key,
	col1 FLOAT
);

insert into tb (col1) values(-32768);
insert into tb (col1) values(-10);
insert into tb (col1) values(10);

select * from tb where col1 < TO_TIME('10:30:20 AM');

drop table tb;

