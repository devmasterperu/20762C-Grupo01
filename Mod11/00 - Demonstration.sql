--select * from (execute [Production].[GetBlueProducts])
--select * from (execute [Production].[GetBlueProducts])
--select * from HumanResources.f_Employees(1)

/*Inserted and Deleted Virtual Tables*/

begin tran
	update HumanResources.Employee
	set   JobTitle='Chief Technology Officer',HireDate='2020-12-23'
	output deleted.JobTitle,inserted.JobTitle,deleted.HireDate,inserted.HireDate
	where NationalIDNumber=295847284
rollback

SET NOCOUNT OFF

select * from HumanResources.f_Employees(1)