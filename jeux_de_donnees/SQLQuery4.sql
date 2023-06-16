/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * INTO [SSISDemo].[dbo].[Customerinfo2] FROM [SSISDemo].[dbo].[Customerinfo]
SELECT * FROM [SSISDemo].[dbo].[Customerinfo2]
SELECT * FROM [SSISDemoStore2].[dbo].[Customerinfo]

ALTER TABLE [SSISDemo].[dbo].[Customerinfo2]
USE SSISDemo;
EXEC sp_rename 'Customerinfo2.file_full_path', 'full_file_path';

DELETE FROM [SSISDemo].[dbo].[Customerinfo2]

CREATE TABLE [SSISDemo].[dbo].[LogError]
(
id int,
package nvarchar(55),
eror_message nvarchar(255)
);

SELECT * FROM [SSISDemo].[dbo].[LogError]

USE SSISDemo;
EXEC sp_rename 'LogError.eror_message', 'error_message';