/*
Test Case: update & select
Priority: 1
Reference case:
Author: Bobo

Test Point:
1. Reading queries can only have a look at data committed before the queries began
2. Uncommitted data or changes committed after the query started are never seen;
3. The only visible uncommitted data are the effects of current transaction's dates, that is to say
   the new version is only visible to the current transaction
C1 select; C2, C3 update, overlap; 

NUM_CLIENTS = 3
C1: Select on table t1. Check the select results   
C2: update on table t1, commit before C3 start  
C3: update on table t1, commit/rollback after C3 start  
*/


MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t1;
C1: create table t1(id int, col varchar(5));
C1: commit work;
MC: wait until C1 ready;
C1: insert into t1 values(1,'abc');insert into t1 values(2,'def');insert into t1 values(3,'ghijk');insert into t1 values(4,'lmn');insert into t1 values(5,'aaa');insert into t1 values(2,'op');insert into t1 values(6,'def');
C1: commit work;
MC: wait until C1 ready;

/* test case 1*/
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: update t1 set col='aaa' where id=1;
C2: commit;	
MC: wait until C2 ready;

C3: update t1 set col='dddd' where col='aaa';
MC: wait until C3 ready;

C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;

C3: commit;
MC: wait until C3 ready;
C1: commit;
MC: wait until C1 ready;
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
C3: rollback;
MC: wait until C3 ready;
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;
C1: commit;
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
C3: commit;
MC: wait until C3 ready;

/* test case 2*/
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: update t1 set col='def' where id<4;
C2: commit;
MC: wait until C2 ready;

C3: update t1 set col='ggg' where col='def';
MC: wait until C3 ready;

C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;

C3: rollback;
MC: wait until C3 ready;
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;
C1: commit;
C2: commit;
C3: commit;
MC: wait until C1 ready;
MC: wait until C2 ready;
MC: wait until C3 ready;
C1: select * from t1 order by 1,2;
MC: wait until C1 ready;
C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;
C1: commit;
C2: commit;
C3: commit;


C1: quit;
C2: quit;
C3: quit;
