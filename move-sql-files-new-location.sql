SELECT name, physical_name AS CurrentLocation, state_desc  
FROM sys.master_files  
WHERE database_id = DB_ID(N'RCSQL');  --Change RCSQL to your database name

ALTER DATABASE RCSQL MODIFY FILE ( NAME = data, FILENAME = 'D:\RCSQL.mdf' );  --Change database name to your database name and the path to your new database path
ALTER DATABASE RCSQL MODIFY FILE ( NAME = log, FILENAME = 'L:\RCSQLLog.ldf' );  --Change database name to your database name and the path to your new log path

ALTER DATABASE RCSQL SET OFFLINE;  --Change RCSQL to your database name

--Physically move your database file and your log file to their new location

ALTER DATABASE RCSQL SET ONLINE;  --Change RCSQL to your database name

SELECT name, physical_name AS CurrentLocation, state_desc  
FROM sys.master_files  
WHERE database_id = DB_ID(N'RCSQL');  --Change RCSQL to your database name
