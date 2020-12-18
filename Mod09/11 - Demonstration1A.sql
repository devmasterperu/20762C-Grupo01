-- Step 1 - Switch to the AdventureWorks database

USE AdventureWorks;
GO

-- Step 2 - Execute the sp_configure system stored procedure

EXEC sp_configure;
GO

-- Step 3 - Execute the xp_dirtree extended system stored procedure

EXEC xp_dirtree "E:\GIANFRANCO\CURSOS\20762C\1_EDICION\20762C-Grupo01\Mod09",0,1;
GO

-- Step 4 - Execute the xp_cmdshell extended system stored procedure

-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO  