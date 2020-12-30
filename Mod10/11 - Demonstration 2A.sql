/*Inline Table-Valued Functions*/

create or alter view HumanResources.vw_Employees--OrganizationLevel
as
select NationalIDNumber,LoginID,JobTitle,Gender
from HumanResources.Employee
where Gender='M' --and OrganizationLevel=1

create or alter function HumanResources.f_Employees(@OrganizationLevel int) returns table
as
	return select NationalIDNumber,LoginID,JobTitle,Gender
		   from   HumanResources.Employee
		   where  Gender='M' and OrganizationLevel=@OrganizationLevel

select * from HumanResources.f_Employees(1)

/* Table variables*/

DECLARE @ListOWeekDays TABLE(DyNumber INT,DayAbb VARCHAR(40), WeekName VARCHAR(40))
 
INSERT INTO @ListOWeekDays
VALUES 
(1,'Mon','Monday')  ,
(2,'Tue','Tuesday') ,
(3,'Wed','Wednesday') ,
(4,'Thu','Thursday'),
(5,'Fri','Friday'),
(6,'Sat','Saturday'),
(7,'Sun','Sunday')	

SELECT * FROM @ListOWeekDays
go

create function HumanResources.f_FullName(@name varchar(50),@lastName varchar(50)) 
returns varchar(110)
as
begin
	return (select concat(@name,' ',@lastName))
end

select FirstName,LastName,HumanResources.f_FullName(FirstName,LastName) as FullName
from Person.Person
where HumanResources.f_FullName(FirstName,LastName)='Syed Abbas'

select concat(Title,' ',FirstName,' ',LastName) from Person.Person

