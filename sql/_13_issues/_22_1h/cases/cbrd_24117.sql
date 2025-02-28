DROP TABLE IF EXISTS tbl;
DROP TABLE IF EXISTS tbl_t1;
DROP TABLE IF EXISTS tbl_t2;
DROP VIEW IF EXISTS view_v1;
DROP VIEW IF EXISTS view_v2;


CREATE TABLE tbl (col1 int, col2 int);
INSERT INTO tbl VALUES (1,1), (2,2);

CREATE TABLE tbl_t1 SELECT * FROM tbl;
CREATE TABLE tbl_t2 AS SELECT * FROM tbl;

SELECT * FROM tbl_t2;

CREATE VIEW view_v1
SELECT col1
FROM tbl A
WHERE col1 = ( SELECT col1 FROM tbl ORDER BY col1 LIMIT 1 );

CREATE VIEW view_v2 AS
SELECT col1
FROM tbl A
WHERE col1 = ( SELECT col1 FROM tbl ORDER BY col1 LIMIT 1 );

SELECT * FROM view_v2;

SELECT 1 SELECT 2 SELECT 3 SELECT 4;

DROP TABLE IF EXISTS tbl;
DROP TABLE IF EXISTS tbl_t1;
DROP TABLE IF EXISTS tbl_t2;
DROP VIEW IF EXISTS view_v1;
DROP VIEW IF EXISTS view_v2;
