autocommit off;
create view inventory_v3
(p joe.product_v2, q, l, s) as
select * from joe.inventory_c
union all
select * from joe.inventory_c2;
select * from inventory_v3;
rollback;
