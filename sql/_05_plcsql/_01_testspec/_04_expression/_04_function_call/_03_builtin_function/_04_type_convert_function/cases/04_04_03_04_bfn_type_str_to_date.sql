--+ server-message on

-- normal: basic usage of a builtin function call

-- [Revised] The bug in the built-in function STR_TO_DATE('12:00:00 AM', '%r') was fixed by CBRD-25189.
create or replace procedure t () as
begin
    dbms_output.put_line(STR_TO_DATE(NULL, NULL));
    dbms_output.put_line(STR_TO_DATE('00:00:00 AM', NULL));
    dbms_output.put_line(STR_TO_DATE('12:00:00 PM', '%r'));
    dbms_output.put_line(STR_TO_DATE('12:00:00 AM', '%r'));

    dbms_output.put_line(STR_TO_DATE('May 1, 1999 11:30:34', '%M %d, %Y %h:%i:%s'));
    dbms_output.put_line(STR_TO_DATE('May 1, 1999 11:30:34', '%M %d, %Y %H:%i:%s'));
    dbms_output.put_line(STR_TO_DATE('May 1, 1999 11:30:34 AM', '%M %d, %Y %h:%i:%s %p'));
    dbms_output.put_line(STR_TO_DATE('May 1, 1999 11:30:34', '%M %d, %Y %h:%i:%s'));
    dbms_output.put_line(STR_TO_DATE('May 1, 1999 23:30:34', '%M %d, %Y %H:%i:%s'));
    dbms_output.put_line(STR_TO_DATE('May 1, 1999 11:30:34 PM', '%M %d, %Y %h:%i:%s %p'));

    dbms_output.put_line(STR_TO_DATE('11:30:34 AM', '%h:%i:%s %p'));
    dbms_output.put_line(STR_TO_DATE('11:30:34', '%h:%i:%s'));
    dbms_output.put_line(STR_TO_DATE('11:30:34 PM', '%H:%i:%s'));

    dbms_output.put_line(STR_TO_DATE('1999-10-31 23:49:59.123', '%Y-%m-%d %H:%i:%s.%f'));
    dbms_output.put_line(STR_TO_DATE('1999-10-31 23:49:59.100', '%Y-%m-%d %H:%i:%s.%f'));
    dbms_output.put_line(STR_TO_DATE('1999-10-31 23:49:59.001', '%Y-%m-%d %H:%i:%s.%f'));
    dbms_output.put_line(STR_TO_DATE('1999-10-31 23:49:59.0001', '%Y-%m-%d %H:%i:%s.%f'));
    dbms_output.put_line(STR_TO_DATE('1999-10-31 23:49:59.000', '%Y-%m-%d %H:%i:%s.%f'));
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t();

drop procedure t;

--+ server-message off
