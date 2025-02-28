--+ holdcas on;

drop table if exists code, AA ;

CREATE TABLE CODE ( S_NAME CHAR(10));

SELECT
 RANK() OVER(PARTITION BY s_name ORDER BY MY_AMT ASC) AS MY_RANK_ASC,
 RANK() OVER(PARTITION BY s_name ORDER BY MY_AMT DESC) AS MY_RANK_DESC,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT ASC) AS OTHER_RANK_ASC,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT DESC) AS OTHER_RANK_DESC
FROM
 (
   SELECT /*+ NO_MERGE */ 
   S_NAME, '1' AS my_amt, '1' AS other_amt
   FROM code
 ) A;
 

CREATE TABLE AA AS SELECT S_NAME, '1' AS my_amt, '1' AS other_amt FROM CODE;

SELECT
 RANK() OVER(PARTITION BY s_name ORDER BY MY_AMT ASC) AS MY_RANK_ASC,
 RANK() OVER(PARTITION BY s_name ORDER BY MY_AMT DESC) AS MY_RANK_DESC,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT ASC) AS OTHER_RANK_ASC,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT DESC) AS OTHER_RANK_DESC
FROM AA;

insert into code values ('111'), ('222'), ('333');

SELECT
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT ASC) AS OTHER_RANK_ASC,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT ASC) AS OTHER_RANK_ASC1,
 RANK() OVER(PARTITION BY s_name ORDER BY OTHER_AMT DESC) AS OTHER_RANK_DESC
FROM
 (
   SELECT /*+ NO_MERGE */ 
  S_NAME, '1' AS my_amt, '1' AS other_amt
   FROM code
 ) A order by 1,2,3;
  
drop table if exists CODE, AA ;

--+ holdcas off;
