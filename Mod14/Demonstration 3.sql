-- Demonstration 3

-- Step 1 - Open a new query window against tempdb

USE tempdb;
GO

-- Step 2 - Create a primary XML index

CREATE PRIMARY XML INDEX IX_ProductImport_ProductDetails
ON dbo.ProductImport (ProductDetails);
GO

-- Step 3 - Create a secondary VALUE index

CREATE XML INDEX IX_ProductImport_ProductDetails_Value
ON dbo.ProductImport (ProductDetails)
USING XML INDEX IX_ProductImport_ProductDetails
FOR VALUE;
GO

-- Step 4 - Query the sys.xml_indexes system view

SELECT * FROM sys.xml_indexes;
GO

-- Step 5 - Drop and recreate the table without a primary key

DROP TABLE dbo.ProductImport;
GO

CREATE TABLE dbo.ProductImport
( ProductImportID int IDENTITY(1,1),
  ProductDetails xml (CONTENT dbo.ProductDetailsSchema)
);
GO

-- Step 6 - Now try to re-add the primary xml index. Note that this will fail.

CREATE PRIMARY XML INDEX IX_ProductImport_ProductDetails
ON dbo.ProductImport (ProductDetails);
GO

-- Step 7 - Querying using primary and secondary indexs.

USE AdventureWorks
GO

-- create primary XML index
CREATE PRIMARY XML INDEX PXML_Person_Demographics ON Person.Person (Demographics);

-- create secondary XML indexes
CREATE XML INDEX XMLPATH_Person_Demographics ON Person.Person (Demographics)
USING XML INDEX PXML_Person_Demographics FOR PATH;

CREATE XML INDEX XMLPROPERTY_Person_Demographics ON Person.Person (Demographics)
USING XML INDEX PXML_Person_Demographics FOR PROPERTY;

CREATE XML INDEX XMLVALUE_Person_Demographics ON Person.Person (Demographics)
USING XML INDEX PXML_Person_Demographics FOR VALUE;

--select Demographics from Person.Person
set statistics io on

WITH XMLNAMESPACES 
('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns)
--SELECT COUNT(1)
SELECT Demographics
FROM Person.Person
WHERE Demographics.exist('(/ns:IndividualSurvey/ns:Occupation[.="Professional"])')=1;

