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

/*Unique constraints*/
CREATE TABLE dbo.Opportunity
(
OpportunityID int NOT NULL CONSTRAINT PK_Opportunity PRIMARY KEY,
Requirements nvarchar(50) NOT NULL CONSTRAINT UQ_Opportunity_Requirements UNIQUE,
ReceivedDate date NOT NULL
);

insert into dbo.Opportunity values(1,'requirement 1','2020-11-30')
go
insert into dbo.Opportunity values(2,'requirement 2','2020-11-30')
go

CREATE TABLE dbo.Cliente
(
tipodoc int,
numdoc  varchar(15)
);

ALTER TABLE Cliente   
ADD CONSTRAINT UQ_Customer_Tipo_Num_Doc UNIQUE (tipodoc,numdoc);   
GO  

insert into dbo.Cliente values (1,'46173384')
go
insert into dbo.Cliente values (3,'46173384')
go
insert into dbo.Cliente values (1,'46173384')
go

/*ON DELETE SET NULL*/
create table Themes --Tabla padre
(
	ThemeID int primary key,
	ThemeName varchar(100),
)

create table Users --Tabla hija
(
	UserID int primary key,
	UserName varchar(100),
	ThemeID int constraint Users_ThemeID_FK references Themes(ThemeID) 
)

insert into Themes (ThemeID, ThemeName) values (1,'Default')
insert into Themes (ThemeID, ThemeName) values (2,'Winter')

insert into Users(UserID, UserName, ThemeID) values (1,'JSmith',null)
insert into Users(UserID, UserName, ThemeID) values (2,'Ted',1)
insert into Users(UserID, UserName, ThemeID) values (3,'Mary',2)

-- remove the existing constraint:
alter table users drop constraint Users_ThemeID_FK

-- This time, create it with on delete set null:
alter table users add constraint Users_ThemeID_FK 
foreign key (ThemeID) references Themes(ThemeID) on delete set null

-- And now delete ThemeID 2 again:
select * from Themes
select * from Users
delete from Themes where ThemeID =2

-- Let's see what we've got:
select * from Users

/*ON DELETE SET DEFAULT*/

drop table Users
go

create table Users
(
	UserID int primary key,
	UserName varchar(100),
	ThemeID int default 1 constraint Users_ThemeID_FK 
	references Themes(ThemeID) on delete set default
)
go

-- Add ThemeID 2 back in:
insert into Themes (ThemeID, ThemeName) values (2,'Winter')

-- Re-create our users again:
insert into Users(UserID, UserName, ThemeID) values (1,'JSmith',null)
insert into Users(UserID, UserName, ThemeID) values (2,'Ted',1)
insert into Users(UserID, UserName, ThemeID) values (3,'ARod',2)

-- Now, delete ThemeID 2:
select * from Themes
select * from Users
delete from Themes where ThemeID = 2

-- And let's see what we've got:
select * from Users
