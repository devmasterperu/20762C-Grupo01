--OPENXML Function

DECLARE @xmldoc AS int, @xml AS xml;

--SELECT  Resume FROM HumanResources.JobCandidate WHERE JobCandidateID=1;
SELECT  @xml=Resume FROM HumanResources.JobCandidate WHERE JobCandidateID=1;

EXEC    sp_xml_preparedocument 
        @xmldoc OUTPUT, 
		@xml,
        '<root xmlns:ns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"/>';

PRINT   'xmldoc:'+cast(@xmldoc as varchar(100))

SELECT * FROM OPENXML(@xmldoc, '/ns:Resume/ns:Employment',2)
WITH (
  [ns:Emp.StartDate] DATETIME,
  [ns:Emp.EndDate] DATETIME,
  [ns:Emp.OrgName] NVARCHAR(1000)
)

EXEC sp_xml_removedocument @xmldoc;