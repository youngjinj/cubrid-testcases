drop if exists t;
CREATE TABLE t (col1 INT, col2 INT, col3 INT);
CREATE INDEX i_t_col1_col2_col3 ON t (col1,col2,col3);
INSERT INTO t VALUES (1,2,3),(4,5,6),(10,8,9);
update t set col3=col3+1000 WHERE col1 < 6 limit 1-1-1-1-1-1-1-1-1-1-1+100000000;
update t set col3=col3+1000 WHERE col1 < 6 using index i_t_col1_col2_col3  keylimit 1-1-1-1-1-1-1-1-1-1-1+100000000;
update t set col3=col3+1000 WHERE col1 < 6 using index i_t_col1_col2_col3  keylimit 0,1-1-1-1-1-1-1-1-1-1-1+100000000;
update t set col3=col3+1000 WHERE col1 < 6 using index i_t_col1_col2_col3  keylimit 1,1-1-1-1-1-1-1-1-1-1-1+100000000; 

CREATE INDEX i_t_col1_col2 ON t (col1,col2);
update t set col3=col3+1000 WHERE col1< 6 order by col1,col2 limit 1-1-1-1-1-1-1-1-1-1-1+100000000;
update t set col3=col3+1000 WHERE col1< 6 order by col1,col2;
update t set col3=col3+1000 WHERE col1< 6 order by col1,col2 limit 2;
drop if exists t;
