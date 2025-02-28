--+ server-message on
-- Verified for CBRD-24565

-- error caused usage of operator '~'

create or replace procedure t () as
begin
    dbms_output.put_line(~9223372036854775808); -- bigint over
exception
    when value_error then
	dbms_output.put_line('bigint limit over');
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t();

drop procedure t;

--+ server-message off
