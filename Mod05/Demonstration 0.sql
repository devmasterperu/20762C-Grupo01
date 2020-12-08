create table Employees
(
id int primary key,
name varchar(100),
salary decimal(8,2),
gender varchar(1)
)

insert into Employees values (6,'Gianfranco Manrique',1000.00,'M')
go
insert into Employees values (5,'Gian Carlos Manrique',1200.00,'M')
go
insert into Employees values (4,'Jesús Gonzales Manrique',1400.00,'M')
go
insert into Employees values (3,'Sofía Valentín Chavez',1800.00,'F')
go
insert into Employees values (2,'Carolina Valentín Chavez',2000.00,'F')
go
insert into Employees values (1,'Tania Azabacher Manrique',2200.00,'F')
go

select * from Employees

sp_helpindex Employees

create clustered index IX_Employees_Gender_Salary
on Employees(Gender desc,salary desc)

create nonclustered index IX_Employees_Name
on Employees(Name asc)

select * from Employees
where name='Jesús Gonzales Manrique'