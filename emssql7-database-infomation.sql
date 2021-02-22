IF OBJECT_ID('tempdb..#details') IS NOT NULL
    DROP TABLE #details;

CREATE TABLE #details (
serverName VARCHAR(10),
serverType VARCHAR(6),
dbName VARCHAR(100),
dataMB INT,
dataGB INT,
logMB INT,
logGB INT,
totalsizeMB INT,
totalsizeGB INT,
recoveryModel VARCHAR(10),
version VARCHAR(10),
mdbFile VARCHAR(255)
)

INSERT INTO #details
SELECT 'EMSSQL7' as Servername, 'MSSQL' AS Servertype,
CONVERT(VARCHAR(100), DB.name) AS dbName,
--CONVERT(VARCHAR(10), DATABASEPROPERTYEX(name, 'status')) AS [Status],
--(SELECT COUNT(1) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid !=0 ) AS DataFiles,
(SELECT SUM((size*8)/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0) AS [Data MB],
(SELECT SUM((size*8)/1024/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0) AS [Data GB],
--(SELECT COUNT(1) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) AS LogFiles,
(SELECT SUM((size*8)/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) AS [Log MB],
(SELECT SUM((size*8)/1024/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) AS [Log GB],
(SELECT SUM((size*8)/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0)+(SELECT SUM((size*8)/1024)
FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) [Total Size MB],
(SELECT SUM((size*8)/1024/1024) FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0)+(SELECT SUM((size*8)/1024/1024)
FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) [Total Size GB],
--convert(sysname,DatabasePropertyEx(name,'Updateability')) Updateability,
--convert(sysname,DatabasePropertyEx(name,'UserAccess')) UserAccess ,
convert(sysname,DatabasePropertyEx(name,'Recovery')) RecoveryModel ,
convert(sysname,DatabasePropertyEx(name,'Version')) Version ,
(SELECT filename FROM sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0) AS [File]
--,CASE cmptlevel
--WHEN 60 THEN '60 (SQL Server 6.0)'
--WHEN 65 THEN '65 (SQL Server 6.5)'
--WHEN 70 THEN '70 (SQL Server 7.0)'
--WHEN 80 THEN '80 (SQL Server 2000)'
--WHEN 90 THEN '90 (SQL Server 2005)'
--WHEN 100 THEN '100 (SQL Server 2008)'
--END AS [compatibility level],
--CONVERT(VARCHAR(20), crdate, 103) + ' ' + CONVERT(VARCHAR(20), crdate, 108) AS [Creation date],ISNULL((SELECT TOP 1
--CASE TYPE WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
--LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),Backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
--CONVERT(VARCHAR(20), backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_start_date, 108) + ' – ' +
--CONVERT(VARCHAR(20), backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_finish_date, 108) +
--' (' + CAST(DATEDIFF(second, BK.backup_start_date,BK.backup_finish_date) AS VARCHAR(4)) + ' '+ 'seconds)'
--FROM msdb.dbo.backupset BK WHERE BK.database_name = DB.name ORDER BY backup_set_id DESC),'-') AS [Last backup]
FROM sysdatabases DB where dbid > 4

IF OBJECT_ID('tempdb..#cteFull') IS NOT NULL
    DROP TABLE #cteFull;

CREATE TABLE #cteFull (
dbName VARCHAR(100),
fullBackupdays VARCHAR(25),
fullBackuptime TIME
)

INSERT INTO #cteFull
SELECT DISTINCT CASE 
		 WHEN name IN('RCSQL_Backup_Full') THEN 'RCSQL'
		 WHEN name IN('All_But_RCSQL_Backup_Full') THEN 'All_Except_RCSQL'
		 WHEN name IN('SystemDatabase_Backup_Full') THEN 'System Databases'
		 ELSE name
END AS dbName,
CASE WHEN name LIKE '%full%' THEN REPLACE
(
 CASE WHEN freq_interval&1 = 1 THEN 'Sunday, ' ELSE '' END
+CASE WHEN freq_interval&2 = 2 THEN 'Monday, ' ELSE '' END
+CASE WHEN freq_interval&4 = 4 THEN 'Tuesday, ' ELSE '' END
+CASE WHEN freq_interval&8 = 8 THEN 'Wednesday, ' ELSE '' END
+CASE WHEN freq_interval&16 = 16 THEN 'Thursday, ' ELSE '' END
+CASE WHEN freq_interval&32 = 32 THEN 'Friday, ' ELSE '' END
+CASE WHEN freq_interval&64 = 64 THEN 'Saturday, ' ELSE '' END
,', '
,''
) END AS fullBackupdays,
CASE WHEN name LIKE '%full%' THEN (case len(active_start_time)
    when 1 then cast('00:00:0' + right(active_start_time,2) as char(8))
    when 2 then cast('00:00:' + right(active_start_time,2) as char(8))
    when 3 then cast('00:0'
            + left(right(active_start_time,3),1)  
            +':' + right(active_start_time,2) as char (8))
    when 4 then cast('00:'
            + left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 5 then cast('0'
            + left(right(active_start_time,5),1) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 6 then cast(Left(right(active_start_time,6),2) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
END ) END AS fullBackuptime
FROM msdb.dbo.sysschedules
WHERE name LIKE '%Backup_Full%'

IF OBJECT_ID('tempdb..#cteDiff') IS NOT NULL
    DROP TABLE #cteDiff;

CREATE TABLE #cteDiff (
dbName VARCHAR(50),
diffBackupdays VARCHAR(100),
diffBackuptime TIME
)

INSERT INTO #ctediff
SELECT DISTINCT CASE 
		 WHEN name IN('RCSQL_Backup_Diff') THEN 'RCSQL'
		 WHEN name IN('All_But_RCSQL_Backup_Diff') THEN 'All_Except_RCSQL'
		 WHEN name IN('SystemDatabases_Backup_Diff') THEN 'System Databases'
END AS dbName,

replace
(
 CASE WHEN freq_interval&1 = 1 THEN 'Sunday, ' ELSE '' END
+CASE WHEN freq_interval&2 = 2 THEN 'Monday, ' ELSE '' END
+CASE WHEN freq_interval&4 = 4 THEN 'Tuesday, ' ELSE '' END
+CASE WHEN freq_interval&8 = 8 THEN 'Wednesday, ' ELSE '' END
+CASE WHEN freq_interval&16 = 16 THEN 'Thursday, ' ELSE '' END
+CASE WHEN freq_interval&32 = 32 THEN 'Friday, ' ELSE '' END
+CASE WHEN freq_interval&64 = 64 THEN 'Saturday, ' ELSE '' END
,', '
,''
) diffBackupdays,

CASE WHEN name LIKE '%diff%' THEN (case len(active_start_time)
    when 1 then cast('00:00:0' + right(active_start_time,2) as char(8))
    when 2 then cast('00:00:' + right(active_start_time,2) as char(8))
    when 3 then cast('00:0'
            + left(right(active_start_time,3),1)  
            +':' + right(active_start_time,2) as char (8))
    when 4 then cast('00:'
            + left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 5 then cast('0'
            + left(right(active_start_time,5),1) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 6 then cast(Left(right(active_start_time,6),2) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
END ) END AS diffBackuptime
FROM msdb.dbo.sysschedules
WHERE name LIKE '%Backup_Diff'

IF OBJECT_ID('tempdb..#backups') IS NOT NULL
    DROP TABLE #backups;

CREATE TABLE #backups (
dbName VARCHAR(50),
fullBackupdays VARCHAR(100),
fullBackuptime TIME,
diffBackupdays VARCHAR(100),
diffBackuptime TIME
)

INSERT INTO #backups
SELECT name, NULL, NULL, NULL, NULL
FROM master.dbo.sysdatabases
WHERE dbid > 4

UPDATE #backups
SET fullBackupdays=(SELECT fullBackupdays FROM #cteFull WHERE dbName='RCSQL' AND fullBackupdays IS NOT NULL),
diffBackupdays=(SELECT diffBackupdays FROM #cteDiff WHERE dbName='RCSQL' AND diffBackupdays IS NOT NULL),
fullBackuptime=(SELECT fullBackuptime FROM #cteFull WHERE dbName='RCSQL' AND fullBackuptime IS NOT NULL),
diffBackuptime=(SELECT diffBackuptime FROM #cteDiff WHERE dbName='RCSQL' AND diffBackuptime IS NOT NULL)
WHERE #backups.dbName='RCSQL'

UPDATE #backups
SET fullBackupdays=(SELECT fullBackupdays FROM #cteFull WHERE dbName='All_Except_RCSQL' AND fullBackupdays IS NOT NULL),
diffBackupdays=(SELECT diffBackupdays FROM #cteDiff WHERE dbName='All_Except_RCSQL' AND diffBackupdays IS NOT NULL),
fullBackuptime=(SELECT fullBackuptime FROM #cteFull WHERE dbName='All_Except_RCSQL' AND fullBackuptime IS NOT NULL),
diffBackuptime=(SELECT diffBackuptime FROM #cteDiff WHERE dbName='All_Except_RCSQL' AND diffBackuptime IS NOT NULL)
WHERE #backups.dbName IN('EDW','EDW_Demo', 'EMSurance', 'EMSurance_Dev', 'moveitdmz', 'Admin')

IF OBJECT_ID('tempdb..#maintday') IS NOT NULL
    DROP TABLE #maintday;

CREATE TABLE #maintday (
maintday VARCHAR(100)
)
INSERT INTO #maintday
SELECT DISTINCT CASE WHEN name LIKE 'Index%' THEN 
REPLACE
(
	 CASE WHEN freq_interval&1 = 1 THEN 'Sunday, ' ELSE '' END
	+CASE WHEN freq_interval&2 = 2 THEN 'Monday, ' ELSE '' END
	+CASE WHEN freq_interval&4 = 4 THEN 'Tuesday, ' ELSE '' END
	+CASE WHEN freq_interval&8 = 8 THEN 'Wednesday, ' ELSE '' END
	+CASE WHEN freq_interval&16 = 16 THEN 'Thursday, ' ELSE '' END
	+CASE WHEN freq_interval&32 = 32 THEN 'Friday, ' ELSE '' END
	+CASE WHEN freq_interval&64 = 64 THEN 'Saturday, ' ELSE '' END
	,', '
	,''
) END FROM msdb.dbo.sysschedules WHERE name IS NOT NULL

IF OBJECT_ID('tempdb..#mainttime') IS NOT NULL
    DROP TABLE #mainttime;

CREATE TABLE #mainttime (
mainttime TIME
)
INSERT INTO #mainttime
SELECT DISTINCT CASE WHEN name LIKE 'Index%' THEN 
	(case len(active_start_time)
    when 1 then cast('00:00:0' + right(active_start_time,2) as char(8))
    when 2 then cast('00:00:' + right(active_start_time,2) as char(8))
    when 3 then cast('00:0'
            + left(right(active_start_time,3),1)  
            +':' + right(active_start_time,2) as char (8))
    when 4 then cast('00:'
            + left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 5 then cast('0'
            + left(right(active_start_time,5),1) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 6 then cast(Left(right(active_start_time,6),2) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
END ) END FROM msdb.dbo.sysschedules WHERE name IS NOT NULL

IF OBJECT_ID('tempdb..#indexes') IS NOT NULL
    DROP TABLE #indexes;

CREATE TABLE #indexes (
dbName VARCHAR(50),
indexMaintenancedays VARCHAR(100),
indexMaintenancetime TIME
)

INSERT INTO #indexes
SELECT name, NULL, null
FROM master.dbo.sysdatabases
WHERE dbid > 4

UPDATE #indexes
SET indexMaintenancedays=(SELECT maintday FROM #maintday WHERE maintday IS NOT NULL),
indexMaintenancetime=(SELECT mainttime FROM #mainttime WHERE mainttime IS NOT NULL)

IF OBJECT_ID('tempdb..#dbccday') IS NOT NULL
    DROP TABLE #dbccday;

CREATE TABLE #dbccday (
dbccday VARCHAR(100)
)
INSERT INTO #dbccday
SELECT DISTINCT CASE WHEN name LIKE 'DBCC%' THEN 
REPLACE
(
	 CASE WHEN freq_interval&1 = 1 THEN 'Sunday, ' ELSE '' END
	+CASE WHEN freq_interval&2 = 2 THEN 'Monday, ' ELSE '' END
	+CASE WHEN freq_interval&4 = 4 THEN 'Tuesday, ' ELSE '' END
	+CASE WHEN freq_interval&8 = 8 THEN 'Wednesday, ' ELSE '' END
	+CASE WHEN freq_interval&16 = 16 THEN 'Thursday, ' ELSE '' END
	+CASE WHEN freq_interval&32 = 32 THEN 'Friday, ' ELSE '' END
	+CASE WHEN freq_interval&64 = 64 THEN 'Saturday, ' ELSE '' END
	,', '
	,''
) END FROM msdb.dbo.sysschedules WHERE name IS NOT NULL

IF OBJECT_ID('tempdb..#dbcctime') IS NOT NULL
    DROP TABLE #dbcctime;

CREATE TABLE #dbcctime (
dbcctime TIME
)
INSERT INTO #dbcctime
SELECT DISTINCT CASE WHEN name LIKE 'DBCC%' THEN 
	(case len(active_start_time)
    when 1 then cast('00:00:0' + right(active_start_time,2) as char(8))
    when 2 then cast('00:00:' + right(active_start_time,2) as char(8))
    when 3 then cast('00:0'
            + left(right(active_start_time,3),1)  
            +':' + right(active_start_time,2) as char (8))
    when 4 then cast('00:'
            + left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 5 then cast('0'
            + left(right(active_start_time,5),1) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
    when 6 then cast(Left(right(active_start_time,6),2) 
            +':' + Left(right(active_start_time,4),2)  
            +':' + right(active_start_time,2) as char (8))
END ) END FROM msdb.dbo.sysschedules WHERE name IS NOT NULL

IF OBJECT_ID('tempdb..#dbcc') IS NOT NULL
    DROP TABLE #dbcc;

CREATE TABLE #dbcc (
dbName VARCHAR(50),
dbccCheckdays VARCHAR(100),
dbccChecktime TIME
)

INSERT INTO #dbcc
SELECT name, NULL, null
FROM master.dbo.sysdatabases
WHERE dbid>4 

UPDATE #dbcc
SET dbccCheckdays=(SELECT dbccday FROM #dbccday WHERE dbccday IS NOT NULL),
dbccChecktime=(SELECT dbcctime FROM #dbcctime WHERE dbcctime IS NOT NULL)

SELECT DISTINCT d.serverName, d.serverType, d.dbName, d.dataMB, d.dataGB, d.logMB, d.logGB, d.totalsizeMB, d.totalsizeGB, d.recoveryModel, version, d.mdbFile, 1 AS fullBackuprequired, b.fullBackupdays, LEFT(b.fullBackuptime,8) AS fullBackuptime, CASE WHEN b.diffBackuptime IS NOT NULL THEN 1 ELSE 0 END AS diffBackuprequired, CASE WHEN b.diffBackupdays IS NOT NULL THEN b.diffBackupdays END AS diffBackupdays, LEFT(b.diffBackuptime,8) AS diffBackuptime, 1 AS indexMaintrequired, i.indexMaintenancedays, LEFT(i.indexMaintenancetime,8) AS indexMaintenancetime, 0 AS updateStatsrequired, '' AS updateStatsday, '' AS updateStatstime, 1 AS dbccRequired, dbc.dbccCheckdays AS dbccDay, dbc.dbccChecktime AS dbccTime
FROM #details d
LEFT OUTER JOIN #backups b
ON d.dbName=b.dbName
LEFT OUTER JOIN #indexes i
ON d.dbName=i.dbName
LEFT OUTER JOIN #dbcc dbc
ON d.dbName=dbc.dbName
ORDER BY d.dbName

