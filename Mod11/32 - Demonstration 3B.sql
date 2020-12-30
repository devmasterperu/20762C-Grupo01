-- Demonstration 3B - Replacing Triggers with Computed Columns

-- Step A: Open a new query window 
--         and use the tempdb database

USE tempdb;
GO

-- Step B: Create the dbo.SellingPrice table

CREATE TABLE dbo.SellingPrice
(
	SellingPriceID int IDENTITY(1,1) CONSTRAINT PK_SellingPrice PRIMARY KEY,
	SubTotal decimal(18,2) NOT NULL,
	TaxAmount decimal(18,2) NOT NULL,
	FreightAmount decimal(18,2) NOT NULL,
	ExtendedAmount decimal(18,2) NULL
);
GO

-- Step C: Create a trigger to maintain the ExtendedAmount column

CREATE TRIGGER TR_SellingPrice_InsertUpdate ON dbo.SellingPrice
AFTER INSERT, UPDATE AS 
BEGIN
  SET NOCOUNT ON;
  UPDATE sp
  SET sp.ExtendedAmount = sp.SubTotal + sp.TaxAmount + sp.FreightAmount
  FROM dbo.SellingPrice AS sp
  INNER JOIN inserted AS i
  ON sp.SellingPriceID = i.SellingPriceId;
END;
GO

-- Step D: Test the trigger by inserting some rows
--         and selecting the values inserted

INSERT INTO dbo.SellingPrice
  (SubTotal, TaxAmount, FreightAmount)
  VALUES (12.3, 1.23, 10), (5, 1, 2);
GO

SELECT * FROM dbo.SellingPrice;
GO
 
-- Step E: Drop the table and recreate it with a computed column

DROP TABLE dbo.SellingPrice;
GO

CREATE TABLE dbo.SellingPrice
(
	SellingPriceID int IDENTITY(1,1) CONSTRAINT PK_SellingPrice PRIMARY KEY,
	SubTotal decimal(18,2) NOT NULL,
	TaxAmount decimal(18,2) NOT NULL,
	FreightAmount decimal(18,2) NOT NULL,
	ExtendedAmount AS (SubTotal + TaxAmount + FreightAmount) PERSISTED
);
GO

-- Step F: Reinsert the data to ensure the behavior is maintained
--         Note that it would now be more efficient

--set statistics io on

INSERT INTO dbo.SellingPrice
  (SubTotal, TaxAmount, FreightAmount)
  VALUES (12.3, 1.23, 10), (5, 1, 2);
GO

SELECT * FROM dbo.SellingPrice;
GO

-- Step G: Drop the table

DROP TABLE dbo.SellingPrice;
GO

-- Step H:
USE AdventureWorks
go

DROP TRIGGER Production.pdate_ListPriceAudit

--drop table Production.ListPriceAudit
--select 1 as ProductiD, ListPrice, SYSDATETIME() as ChangedWhen
--into Production.ListPriceAudit
--from Production.Product
--where 1=0

select * from Production.Product

CREATE TRIGGER Production.pdate_ListPriceAudit
ON Production.Product AFTER UPDATE AS
BEGIN
	IF UPDATE(ListPrice) and exists(select 1 from inserted as i 
									inner join deleted as j on i.ProductiD=j.ProductiD and i.ListPrice<>j.ListPrice)
	BEGIN
		INSERT INTO Production.ListPriceAudit (ProductID, ListPrice,ChangedWhen)
		SELECT i.ProductiD, i.ListPrice, SYSDATETIME() FROM inserted AS i
		inner join deleted as j on i.ProductiD=j.ProductiD and i.ListPrice<>j.ListPrice;
	END;
END;

select ProductID,Name,ListPrice from Production.Product
where  ProductID in (1,2)

update Production.Product
set    ListPrice=12.00
where  ProductID in (1,2)

update Production.Product
set    ListPrice=case when ProductID=1 then 12.00 else 14.00 end
where  ProductID in (1,2)

select ProductID,ListPrice,ChangedWhen 
from   Production.ListPriceAudit
where  ProductID in (1,2)