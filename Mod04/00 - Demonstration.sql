/*Default constraints*/
select * from INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE 
select * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE 
select * from sys.default_constraints

--DROP TABLE dbo.SalesOrder
CREATE TABLE dbo.SalesOrder
(
OpportunityID int,
--ReceivedDate date NOT NULL CONSTRAINT DF_SalesOrder_Date DEFAULT (SYSDATETIME()),
ReceivedDate date NOT NULL DEFAULT (SYSDATETIME()),
ProductID int NOT NULL,
Salesperson1D int NOT NULL
);

/*Check constraints*/
--(1)
declare @ItemCost decimal(6,2)=9999.99

--drop table dbo.GroceryItem
CREATE TABLE dbo.GroceryItem
(
ItemCost decimal(6,2) NULL,
CONSTRAINT CHKGroceryItem_ItemCostRange
CHECK (ItemCost > 0 AND ItemCost < 1000)
);

insert into GroceryItem values (100)
go
insert into GroceryItem values (950)
go
insert into GroceryItem values (1000)
go
insert into GroceryItem values (9999.99)
go
insert into GroceryItem values (null)
go
select * from GroceryItem

--(2)
CREATE TABLE dbo.Message
(
MessageTag char(5) NOT NULL,
Comment nvarchar(max) NULL
);

ALTER TABLE dbo.Message ADD CONSTRAINT CHKMessage_MessageTagFormat
CHECK (MessageTag LIKE '[A-Z]-[0-9][0-9][0-9]');

ALTER TABLE dbo.Message ADD CONSTRAINT CHKMessage_CommentNotEmpty
CHECK (LEN(Comment) > 0);

insert into dbo.Message values ('9_123','test')
go
insert into dbo.Message values ('A_123','test')
go
insert into dbo.Message values ('A-B23','test')
go
insert into dbo.Message values ('A-123','')
go
insert into dbo.Message values ('A-123','test')
go

