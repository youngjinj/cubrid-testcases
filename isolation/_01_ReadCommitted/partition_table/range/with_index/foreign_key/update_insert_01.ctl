/*
Test Case: insert & update
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/foreign_key_column/insert_update_02.ctl
Author: Rong Xu

Test Point:
B reference A, when there is overlap, test the behavior
there is rollback

NUM_CLIENTS = 2
A update from referenced table, change 1 to 20
B insert into reference table, insert 20 --expected hang in here
A commit 
B commit

*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists child;
C1: drop table if exists father;
C1: create table father(id int primary key,col varchar(10)) partition by range(id)(partition p1 values less than (10),partition p2 values less than (100)); 
C1: create table child(id int,col varchar(10),foreign key(id) references father(id));
C1: insert into father values(1,'a');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: update father set id=20 where id=1;
MC: wait until C1 ready;
C2: insert into child values(20,'mm');
MC: wait until C2 blocked;
C1: commit;
MC: wait until C2 ready;
C2: commit;

/* expected father (20,'a'); child (20,mm) */
C2: select * from father order by 1;
C2: select * from child order by 1,2;
C2: commit;

C2: quit;
C1: quit;

