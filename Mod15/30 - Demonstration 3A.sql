--Geometry Methods Supported by Spatial Indexes

--STContains 

DECLARE @g geometry = geometry::STGeomFromText('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))', 0);
DECLARE @h geometry = geometry::STGeomFromText('POINT(1 1)', 0);
SELECT  @g 
UNION ALL 
SELECT  @h 
SELECT  @g.STContains(@h);--geometry1.STContains(geometry2) = 1
GO

--STDistance

DECLARE @g geometry = geometry::STGeomFromText('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))', 0);
DECLARE @h geometry = geometry::STGeomFromText('POINT(10 10)', 0);
SELECT  @g
UNION  ALL
SELECT  @h 
SELECT  @g.STDistance(@h);--geometry1.STDistance(geometry2) < number or <= number
GO

--STEquals

DECLARE @g geometry = geometry::STGeomFromText('LINESTRING(0 2, 2 0, 4 2)', 0);
DECLARE @h geometry = geometry::STGeomFromText('MULTILINESTRING((4 2, 2 0), (0 2, 2 0))', 0);
SELECT  @g
UNION  ALL
SELECT  @h 
SELECT  @g.STEquals(@h);
GO

--STOverlaps

DECLARE @g geometry = geometry::STGeomFromText('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))', 0);  
DECLARE @h geometry = geometry::STGeomFromText('POLYGON((1 1, 3 1, 3 3, 1 3, 1 1))', 0);  
SELECT  @g
UNION  ALL
SELECT  @h 
SELECT  @g.STOverlaps(@h); --geometry1.STOverlaps(geometry2) = 1
GO

--STWithin

DECLARE @g geometry = geometry::STGeomFromText('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))', 0); 
DECLARE @h geometry = geometry::STGeomFromText('POLYGON((1 1, 3 1, 3 3, 1 3, 1 1))', 0); 
--DECLARE @g geometry = geometry::STGeomFromText('POLYGON((1 1, 1 2, 2 2, 2 1, 1 1))', 0); 
SELECT  @g
UNION   ALL
SELECT  @h 
SELECT  @g.STWithin(@h);

--geography1.STIntersects(geography2) = 1
--geography1.STEquals(geography2) = 1
--geography1.STDistance(geography2) < number
--geography1.STDistance(geography2) <= number