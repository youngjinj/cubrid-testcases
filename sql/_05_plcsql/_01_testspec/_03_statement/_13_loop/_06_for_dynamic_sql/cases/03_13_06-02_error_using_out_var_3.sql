--+ server-message on
-- Verified for CBRD-24708

-- error: specifying OUT, INOUT, or IN OUT in using clause

create or replace procedure t(i int) as
    j int := 3;
begin
    for r in (execute immediate 'select * from db_collation where coll_id > ?' using IN OUT j) loop
        null;
    end loop;
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

--+ server-message off
