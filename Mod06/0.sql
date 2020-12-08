/*Filtered index*/
Use AdventureWorks
go
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'FIBillOfMaterialsWithEndDate'  
           AND object_id = OBJECT_ID (N'Production.BillOfMaterials'))  

DROP INDEX FIBillOfMaterialsWithEndDate ON Production.BillOfMaterials  
GO  

set statistics io on
SELECT ProductAssemblyID, ComponentID, StartDate   
FROM Production.BillOfMaterials  
WHERE EndDate IS NOT NULL   
      AND ComponentID = 324 AND StartDate > '01/01/2004' ;  
GO  

set statistics io on
CREATE NONCLUSTERED INDEX FIBillOfMaterialsWithEndDate  
    ON Production.BillOfMaterials (ComponentID, StartDate)  
    WHERE EndDate IS NOT NULL ;  
GO  

/*Fill factor*/
EXEC sp_configure 'show advanced options', '1';
RECONFIGURE;

sp_configure 'fill factor';
sp_configure 'fill factor',50;

/*Pad index*/
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_AddressID_City_PostalCode'  
           AND object_id = OBJECT_ID (N'Person.Address'))  
	DROP INDEX IX_AddressID_City_PostalCode ON Person.Address
GO  

CREATE INDEX IX_AddressID_City_PostalCode
ON Person.Address
(AddressID, City, PostalCode)
WITH PAD_INDEX, FILLFACTOR = 80;
GO

/*Managing Statistics*/
ALTER DATABASE AdventureWorks SET AUTO_UPDATE_STATISTICS ON;
GO

/*Methods for capturing plan*/

DBCC USEROPTIONS;
SET SHOWPLAN_TEXT OFF;
SET SHOWPLAN_ALL OFF;
SET SHOWPLAN_XML OFF;
SET STATISTICS PROFILE OFF;
SET STATISTICS XML ON;

SELECT BusinessEntityID   
FROM HumanResources.Employee  
WHERE NationalIDNumber = '509647174';  
GO  



