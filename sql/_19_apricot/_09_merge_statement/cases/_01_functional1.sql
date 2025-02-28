-- This testcase use modified Oracle samples. See below for the license:
-- Copyright (c) 2015 Oracle
-- Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.

create class bonuses (emp_id int, bonus int);
create index i_bonuses_emp_id on bonuses (emp_id);

insert into bonuses values (153,100);
insert into bonuses values (154,100);
insert into bonuses values (155,100);
insert into bonuses values (156,100);
insert into bonuses values (157,100);
insert into bonuses values (158,100);
insert into bonuses values (159,100);
insert into bonuses values (160,100);
insert into bonuses values (161,100);
insert into bonuses values (162,100);
insert into bonuses values (163,100);

create class emp (emp_id int, salary int);
create index i_emp_emp_id  on emp (emp_id);
create index i_emp_emp_id_salary on emp (emp_id, salary);

insert into emp values (153,200);
insert into emp values (154,500);
insert into emp values (155,550);
insert into emp values (156,350);
insert into emp values (157,600);
insert into emp values (158,450);
insert into emp values (159,550);
insert into emp values (160,650);
insert into emp values (161,700);
insert into emp values (162,520);
insert into emp values (163,675);
insert into emp values (201,400);
insert into emp values (202,450);
insert into emp values (203,300);

create class trg (s string);
create class trg2 (s string);

CREATE TRIGGER [tr_su]
  STATUS ACTIVE
  PRIORITY 0.000000
  BEFORE STATEMENT UPDATE ON [bonuses]
  EXECUTE insert into [trg] values ('tr_su');

CREATE TRIGGER [tr_si]
  STATUS ACTIVE
  PRIORITY 0.000000
  BEFORE STATEMENT INSERT ON [bonuses]
  EXECUTE insert into [trg] values ('tr_si');

CREATE TRIGGER [tr_i]
  STATUS ACTIVE
  PRIORITY 0.000000
  BEFORE INSERT ON [bonuses]
  EXECUTE insert into [trg] values ('tr_i');

CREATE TRIGGER [tr_i2]
  STATUS ACTIVE
  PRIORITY 0.000000
  AFTER INSERT ON [bonuses]
  EXECUTE insert into [trg] values ('tr_i2');

CREATE TRIGGER [tr_su2]
  STATUS ACTIVE
  PRIORITY 0.000000
  AFTER STATEMENT UPDATE ON [bonuses]
  EXECUTE insert into [trg] values ('tr_su2');

CREATE TRIGGER [tr_si2]
  STATUS ACTIVE
  PRIORITY 0.000000
  AFTER STATEMENT INSERT ON [bonuses]
  EXECUTE insert into [trg] values ('tr_si2');

CREATE TRIGGER [tr_u]
  STATUS ACTIVE
  PRIORITY 0.000000
  BEFORE UPDATE ON [bonuses]
  EXECUTE insert into [trg2] select 'tr_u' from [db_root];

CREATE TRIGGER [tr_u2]
  STATUS ACTIVE
  PRIORITY 0.000000
  AFTER UPDATE ON [bonuses]
  EXECUTE insert into [trg2] select 'tr_u2' from [db_root];

merge into bonuses using emp on bonuses.emp_id = emp.emp_id when matched then update set bonuses.bonus=bonuses.bonus+emp.salary*0.1 where emp.salary<600;

select * from bonuses order by 1;
select * from trg;
select * from trg2;

drop emp;
drop bonuses;
drop trg;
drop trg2;
