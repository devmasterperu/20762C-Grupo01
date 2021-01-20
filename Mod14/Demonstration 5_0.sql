-- The query() Method
select * from Sales.Store;

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
SELECT Top 3 BusinessEntityID,
Demographics,
Demographics.query('(/StoreSurvey/AnnualRevenue)') AS Revenue,
Demographics.query('(/StoreSurvey/NumberEmployees)') As Staff
FROM Sales.Store;

-- The value() Method

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
SELECT Top 3 BusinessEntityID,
Demographics,
Demographics.value('(/StoreSurvey/AnnualRevenue)[1]','decimal') AS Revenue,
Demographics.value('(/StoreSurvey/NumberEmployees)[1]','int')   As Staff
FROM Sales.Store;

-- The exist() Method

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
SELECT TOP 3 BusinessEntityID,
Demographics,
Demographics.value('(/StoreSurvey/AnnualRevenue)[1]','decimal') AS Revenue,
Demographics.value('(/StoreSurvey/NumberEmployees)[1]','int') As Staff
FROM Sales.Store
--WHERE Demographics.exist('/StoreSurvey[NumberEmployees<14]') = 1;
WHERE Demographics.value('(/StoreSurvey/NumberEmployees)[1]','int')=14

-- The modify() Method

-- Insert a new XML element

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
UPDATE Sales.Store
SET    Demographics.modify('insert(<Comments>Problem with staff levels 2</Comments>) 
	                        after(/StoreSurvey/NumberEmployees)[1]')
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees=14]') = 1;

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
select Demographics
from   Sales.Store
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees=14]') = 1;

-- Delete an XML element

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
UPDATE Sales.Store
SET    Demographics.modify('delete (/StoreSurvey/Comments)[1]')
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees=14]') = 1;

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
select Demographics
from   Sales.Store
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees=14]') = 1;

-- Update the contents on an existing element

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
UPDATE Sales.Store
SET    Demographics.modify('replace value of (/StoreSurvey/JobTitle)[1] with "20762C change"')
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees<99]') = 1;

WITH XMLNAMESPACES ( DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' )
select Demographics
from   Sales.Store
WHERE  Demographics.exist('/StoreSurvey[NumberEmployees<99]') = 1;
