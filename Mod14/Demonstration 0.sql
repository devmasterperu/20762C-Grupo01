/*XML Data*/
DECLARE @Settings xml;
SET @Settings = '<Setup><Application Name="StartUpCleanup"
State="On"></Application><Application Name="Shredder" State="Off">Keeps
Spaces</Application></Setup>';
SELECT @Settings;

/*Introduction to the FOR XML Clause*/

select ProductID,Name,ProductNumber from Production.Product
for XML raw

select 1 as col1,null as col2,3 as col3
for XML raw
