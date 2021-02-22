USE [master];
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('RCSQL')
EXEC(@kill);

USE [master]
GO
ALTER DATABASE [RCSQL] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO
ALTER DATABASE [RCSQL] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
