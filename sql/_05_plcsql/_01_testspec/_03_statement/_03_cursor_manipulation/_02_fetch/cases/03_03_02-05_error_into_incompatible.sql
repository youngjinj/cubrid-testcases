--+ server-message on

-- error: into clause type mismatch

create or replace procedure t(i int) as
    cursor c(cs varchar, b int) is select coll_name from db_collation where charset_name = cs and coll_id > b;
    b boolean;
begin
    open c('utf8', 3);
    fetch c into b;
end;


select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';



--+ server-message off
