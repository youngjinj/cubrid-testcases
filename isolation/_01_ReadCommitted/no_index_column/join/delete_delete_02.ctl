/*
Test Case: delete & delete
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/no_index_column/join/delete_delete_01.ctl
Author: Ray

Test Plan: 
Test DELETE locks (X_LOCK on instance) if the delete instances of the transactions are not overlapped (with multi-tables deletion by using INNER JOIN)

Test Scenario:
C1 delete, C2 delete, the affected rows are not overlapped
C1 commit, C2 commit
Metrics: data size = small, join query = inner join, where clause = simple (mutliple columns), DELETE state = multiple tables deletion

Test Point:
1) C1 and C2 will not be waiting 
2) All the data affected from C1 and C2 should be deleted

NUM_CLIENTS = 3
C1: delete from table t1 inner join table t2;  
C2: delete from table t1 inner join table t2;  
C3: select on table t1; C3 is used to check the updated result
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: DROP TABLE IF EXISTS t2;
C1: CREATE TABLE t1(id INT, col VARCHAR(10));
C1: CREATE TABLE t2(id INT, col VARCHAR(10));
C1: INSERT INTO t1 VALUES(1,'abc'),(2,'def'),(3,'ghi'),(4,'jkl'),(5,'mno'),(6,'pqr'),(7,'abc');
C1: INSERT INTO t2 VALUES(1,'stu'),(2,'vwx'),(3,'yzab'),(4,'abc'),(5,'def'),(6,'jkl'),(7,'mno'),(8,'pqr');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: DELETE a,b FROM t1 a INNER JOIN t2 b ON a.id = b.id WHERE a.id >= 5;
MC: wait until C1 ready;
C2: DELETE a,b FROM t1 a INNER JOIN t2 b ON a.id = b.id WHERE a.id <= 2 or b.col = 'yzab';
/* expect: no transactions need to wait */
MC: wait until C2 ready;
/* expect: C1 select - t1 id = 5,6,7 are deleted, t2 id = 5,6,7 is deleted */
C1: SELECT * FROM t1 order by 1,2;
C1: SELECT * FROM t2 order by 1,2;
MC: wait until C1 ready;
/* expect: C2 select - t1 id = 1,2,3 are deleted, t2 id = 1,2,3 are deleted */
C2: SELECT * FROM t1 order by 1,2;
C2: SELECT * FROM t2 order by 1,2;
MC: wait until C2 ready;
C1: commit;
C2: commit;
/* expect: the instances of t1, t2 id = 1,2,3,5,6,7 are deleted */
C3: select * from t1 order by 1,2;
C3: select * from t2 order by 1,2;

C1: quit;
C2: quit;
C3: quit;
