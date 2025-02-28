/*
Test Case: update & delete
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/partition_table/range/with_index/primary_key/update_delete_08.ctl
Author: Rong Xu

Test Point:
C1 update 1 to 11, C2 delete 1

NUM_CLIENTS = 2
C1: UPDATE t SET id=11 where id=1;
C2: DELETE FROM t WHERE id=1; --expected blocked
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS t;
C1: create table t(id int,col varchar(10)) partition by range(id)(partition p1 values less than (10),partition p2 values less than (100));
C1: INSERT INTO t VALUES(1,'abc');
C1: INSERT INTO t VALUES(12,'abc');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: UPDATE t SET id=11 where id=1;
MC: wait until C1 ready;
C2: DELETE FROM t WHERE id=1;
MC: wait until C2 blocked;

/* expect (11,'abc'),(12,'abc') */
C1: SELECT * FROM t order by 1,2;
C1: commit;
MC: wait until C1 ready;

/* expect serializable error by delete, (1,'abc'),(12,'abc') */
C2: SELECT * FROM t order by 1,2;
C2: commit;
MC: wait until C2 ready;

/* expect (11,'abc'),(12,'abc') */
C2: SELECT * FROM t order by 1,2;
C2: commit;
MC: wait until C2 ready;

C1: quit;
C2: quit;
