set trace on;

/* dummy data */
drop table if exists dummy;
create table dummy (col_a int);
insert into dummy
select rownum from
table ({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}),
table ({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}),
table ({0, 1, 2, 3, 4, 5, 6, 7, 8, 9});

/* ----------------------------------------
 *
 * test case 10
 *   - child c (parent_col_a:not_null)
 *   - sub parent p (c:parent_col_a->p:col_a)
 *   - super parent s
 *
 * ---------------------------------------- */

drop table if exists t_child;
drop table if exists t_parent;
drop table if exists t_super_parent;
create table t_super_parent (col_a int primary key auto_increment, col_b int);
create table t_parent under t_super_parent (c3 int);
create table t_child (col_a int auto_increment primary key, col_b int);
alter table t_child add column parent_col_a int not null references t_parent (col_a); /* not_null */
insert into t_super_parent select null, col_a from dummy;
insert into t_parent select null, (col_a * -1), col_a from dummy;
insert into t_parent select null, (col_a * -1), col_a from dummy;
insert into t_child select null, (col_a * -1), col_a from dummy;
insert into t_child select null, (col_a * -1), col_a from dummy;
insert into t_child select null, (col_a * -1), col_a from dummy;
insert into t_child select null, (col_a * -1), col_a from dummy;

update statistics on t_child with fullscan;
update statistics on t_parent with fullscan;
update statistics on t_super_parent with fullscan;

/* ansi‑style */
select /*+ recompile */
    c.col_a,
    c.col_b
from
    t_parent as p
    inner join t_child as c on c.parent_col_a = p.col_a
where
    c.col_b = -1;
show trace;

select /*+ recompile */
    c.col_a,
    c.col_b
from
    t_child as c,
    t_parent as p
where
    c.parent_col_a = p.col_a
    and c.col_b = -1;
show trace;

drop table if exists t_child;
drop table if exists t_parent;
drop table if exists t_super_parent;


drop table if exists dummy;

set trace off;
