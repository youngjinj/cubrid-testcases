--+ server-message on

-- normal: basic usage of a stored function call


create or replace function foo(i int, j int) return varchar as
begin
    return i || ':' || j;
end;

create or replace procedure t(i int) as
begin
    dbms_output.put_line(foo(2, 3));
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t(7);

drop procedure t;
drop function foo;


--+ server-message off
