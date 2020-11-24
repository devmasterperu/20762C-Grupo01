/*Foreign Keys + cascade option*/

create table t1
(
idt1 integer identity(1,1) primary key
)

alter table t1 add name varchar(100)
select * from t1

--drop table t2
create table t2
(
idt2 integer identity(1,1) primary key,
idt1 integer references t1(idt1) --on delete cascade
)

insert into t1 values('a'),('b'),('c')
insert into t2 values (1)
insert into t2 values (3)
select * from t1
select * from t2

delete from t1 where idt1=1

select * from t1
select * from t2

select * from INFORMATION_SCHEMA.TABLES
select * from INFORMATION_SCHEMA.COLUMNS
select * from dbo.backupset
select * from dbo.restorehistory
select * from dbo.sysjobhistory

/*Concurrency*/
Use TSQL

begin tran
	update e
	set e.lastname='Manrique'
	from HR.Employees e
	where empid=8
commit

/*@@Identity and scope_identity*/

--drop table t1
create table t1
(
id integer identity(1,1) primary key,
value varchar(1)
)

--drop table t2
create table t2
(
id integer identity(1,1) primary key,
value varchar(1)
)
drop trigger trForInsert
create trigger trForInsert on t1 for insert
as
begin
	Insert into t2 values ('b')
end

insert into t1 values ('d')

select SCOPE_IDENTITY()
select @@IDENTITY
select IDENT_CURRENT('dbo.t1')
select IDENT_CURRENT('dbo.t2')

select * from t1
select * from t2

/*Sequence*/
CREATE SEQUENCE CategoryID2 AS int
START WITH 10
INCREMENT BY 2;

select next value for CategoryID

ALTER SEQUENCE CategoryID2
RESTART WITH 10;

select next value for CategoryID2

declare @salary numeric(10,2)

/*Unique identifiers*/

declare @id uniqueidentifier=NEWID() 
select @id
--99508792-BB24-4C01-B328-80547471B8C3
create table Person
(
 id uniqueidentifier primary key default NEWID(),
 name varchar(100)
)

insert into Person(name) values ('Jesús'),('Juan')

select * from Person

/*NULL and NOT NULL*/
ALTER DATABASE AdventureWorks SET ANSI_NULL_DEFAULT OFF;  --NOT NULL
GO  

--drop table tTest
create table tTest
(
value integer 
)

insert into tTest values (null)

ALTER DATABASE TSQL SET ANSI_NULL_DEFAULT ON;  
GO  

--drop table tbTest2
create table tbTest2
(
value integer 
)

insert into tbTest2 values (null)

/*Alias data type*/

Use model
go

drop type cellphone --Elimina alias tipo dato

CREATE TYPE cellphone  
FROM varchar(9) NOT NULL ; --Crear alias tipo dato

create table Person
(
cellphonenum cellphone
)

select * from sys.types

insert into Person values ('995995177')

select * from Person

declare @number cellphone='995995177'
select  @number as cellphonenum

create database Test2
go

use Test2
go
create table People
(
cellphone cellphone
)


/*Converting data between data types*/
SELECT CAST(GETDATE() AS nvarchar(50)) AS DateToday;
SELECT CAST('93751' AS int) AS ConvertedString;
SELECT CAST('93751.3' AS int) AS ConvertedString;
SELECT CONVERT(nvarchar(50), GETDATE(), 114) AS DateToday;
SELECT PARSE('Monday, 13 December 2010' AS datetime2 USING 'en-US') AS Result;

SELECT * FROM sys.syslanguages

--SET LANGUAGE 'Spanish';--2010-11-12 00:00:00.0000000  
--SET LANGUAGE 'English';  --2010-12-11 00:00:00.0000000
SELECT PARSE('12/11/2010' AS datetime2) AS Result;

SELECT TRY_CAST('93751' AS int) AS ConvertedString;
SELECT TRY_CAST('93751.3' AS int) AS ConvertedString;
SELECT TRY_CONVERT(int,'93751.3') AS ConvertedInteger;