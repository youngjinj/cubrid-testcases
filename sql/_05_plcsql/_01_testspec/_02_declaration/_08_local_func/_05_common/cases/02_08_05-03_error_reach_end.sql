--+ server-message on

-- error: local function may not reach the end of the body without encountering a return statement

create or replace procedure t(i int) as
    function foo return int as
    begin
        null;
    end;
begin
    null;
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';


--+ server-message off
