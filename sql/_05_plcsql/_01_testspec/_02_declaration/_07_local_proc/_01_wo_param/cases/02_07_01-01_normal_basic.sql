--+ server-message on

-- normal: local procedure without parameters


create or replace procedure t(i int) as
    procedure poo as
    begin
        dbms_output.put_line('poo');
    end;

    procedure boo() as
    begin
        dbms_output.put_line('boo');
    end;
begin
    poo();
    boo();
    poo;
    boo;
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t(7);

drop procedure t;


--+ server-message off
