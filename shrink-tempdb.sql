-- report the new file sizes
SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
GO

USE tempdb;
GO
CHECKPOINT;

DBCC SHRINKFILE ('templog'); -- shrink log file
DBCC SHRINKFILE ('tempdev'); -- shrink db file
DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS;
DBCC FREEPROCCACHE WITH NO_INFOMSGS;
DBCC SHRINKFILE ('tempdev'); -- shrink db file
DBCC SHRINKFILE ('templog'); -- shrink log file
DBCC FREESESSIONCACHE WITH NO_INFOMSGS;
DBCC FREESYSTEMCACHE ('ALL');
DBCC SHRINKFILE ('tempdev'); -- shrink db file
DBCC SHRINKFILE ('templog'); -- shrink log file
DBCC SHRINKDATABASE(tempdb, 5);

SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
GO

/*
DBCC FREEPROCCACHE -- clean cache
DBCC DROPCLEANBUFFERS -- clean buffers
DBCC FREESYSTEMCACHE ('ALL') -- clean system cache
DBCC FREESESSIONCACHE -- clean session cache
DBCC SHRINKDATABASE(tempdb, 10); -- shrink tempdb
dbcc shrinkfile ('tempdev') -- shrink db file
dbcc shrinkfile ('templog') -- shrink log file
GO
*/