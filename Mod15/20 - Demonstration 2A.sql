--Geometry Data Type
--https://docs.microsoft.com/en-us/sql/t-sql/spatial-geometry/point-geometry-data-type?view=sql-server-ver15

DECLARE @g geometry = geometry::Point(40,4,0);  
SELECT  @g.ToString() as g,@g;
GO

DECLARE @g geometry = geometry::Parse('POINT(3 4 7 2.5)');
SELECT  @g, @g.STX, @g.STY, @g.Z, @g.M;
GO

--https://docs.microsoft.com/en-us/sql/t-sql/spatial-geometry/stgeomfromtext-geometry-data-type?view=sql-server-ver15

DECLARE @Location geometry = geometry::STGeomFromText('POINT (12 15 2 9)',0);
SELECT  @Location.STAsText();
SELECT  @Location.AsTextZM();
GO

--Geography Data Type

DECLARE @g geography = geography::Point(47.65100, -122.34900, 4326)  
SELECT  @g,@g.ToString();
GO

DECLARE @g geography = geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656)', 4326);  
SELECT  @g, @g.ToString();
GO

--Polygon instances

DECLARE @g1 geometry = 'POLYGON EMPTY';  
DECLARE @g2 geometry = 'POLYGON((1 1, 3 3, 3 1, 1 1))';  
DECLARE @g3 geometry = 'POLYGON((-5 -5, -5 5, 5 5, 5 -5, -5 -5),(0 0, 3 0, 3 3, 0 3, 0 0))';  
DECLARE @g4 geometry = 'POLYGON((-5 -5, -5 5, 5 5, 5 -5, -5 -5),(3 0, 6 0, 6 3, 3 3, 3 0))';  --
DECLARE @g5 geometry = 'POLYGON((1 1, 1 1, 1 1, 1 1))';
SELECT  @g5
go
