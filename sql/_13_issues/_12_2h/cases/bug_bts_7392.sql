--+ holdcas on;
drop table if exists t;

create table t(a int);
insert into t values(1),(10),(11);
select * from t order by a > 10,a desc;
select * from t order by (a > 10), a desc;
select sum(a>10) from t;
select sum((a>10)) from t;
select sum((a>1/0))from t;
select sum((a>1/2))from t;
select sum((a>1+1))from t;
select sum((a>1-0.9))from t;
select sum((a>'a'))from t;
select sum (a>'a')from t;
select sum((a>sum(a)))from t;
select sum((a>ln(a)))from t;
select sum (a=a)from t;
select sum (1=1)from t;
select sum (1=0)from t;
truncate t;
select * from t order by a > 10;
select * from t order by (a > 10);
select sum(a>10) from t;
select sum((a>10)) from t;
select sum((a>1/0))from t;
select sum((a>1/2))from t;
select sum((a>1+1))from t;
select sum((a>1-0.9))from t;
select sum((a>'a'))from t;
select sum (a>'a')from t;
select sum((a>sum(a)))from t;
select sum((a>ln(a)))from t;
select sum (a=a)from t;
select sum (1=1)from t;
select sum (1=0)from t;
drop table t;
commit;
--+ holdcas off;
