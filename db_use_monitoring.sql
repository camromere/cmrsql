SELECT @@ServerName AS server
 ,NAME AS dbname
 ,COUNT(STATUS) AS number_of_connections
 ,GETDATE() AS timestamp
FROM sys.databases sd
LEFT JOIN sysprocesses sp ON sd.database_id = sp.dbid
WHERE database_id NOT BETWEEN 1 AND 4
GROUP BY NAME

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Connections](
 [server] [nvarchar](130) NOT NULL,
 [name] [nvarchar](130) NOT NULL,
 [number_of_connections] [int] NOT NULL,
 [timestamp] [datetime] NOT NULL
) ON [PRIMARY]
GO

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE usp_ConnectionsCount 
AS
BEGIN
 SET NOCOUNT ON;
INSERT INTO Connections 
  SELECT @@ServerName AS server
 ,NAME AS dbname
 ,COUNT(STATUS) AS number_of_connections
 ,GETDATE() AS timestamp
FROM sys.databases sd
LEFT JOIN master.dbo.sysprocesses sp ON sd.database_id = sp.dbid
WHERE database_id NOT BETWEEN 1
  AND 4
GROUP BY NAME
END

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

SELECT NAME
 ,MAX(number_of_connections) AS MAX#
FROM Connections
GROUP BY NAME