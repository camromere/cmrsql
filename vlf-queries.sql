/*USE <db_name>*/ --Set db name before running using drop-down above or this USE statement

DECLARE @file_name sysname,
@file_size int,
@file_growth int,
@shrink_command nvarchar(max),
@alter_command nvarchar(max)

SELECT @file_name = name,
@file_size = (size / 128)
FROM sys.database_files
WHERE type_desc = 'log'

SELECT @shrink_command = 'DBCC SHRINKFILE (N''' + @file_name + ''' , 0, TRUNCATEONLY)'
PRINT @shrink_command
EXEC sp_executesql @shrink_command

SELECT @shrink_command = 'DBCC SHRINKFILE (N''' + @file_name + ''' , 0)'
PRINT @shrink_command
EXEC sp_executesql @shrink_command

SELECT @alter_command = 'ALTER DATABASE [' + db_name() + '] MODIFY FILE (NAME = N''' + @file_name + ''', SIZE = ' + CAST(@file_size AS nvarchar) + 'MB)'
PRINT @alter_command
EXEC sp_executesql @alter_command

/* check vlf sizes */
DECLARE @query varchar(1000),
 @dbname varchar(1000),
 @count int

SET NOCOUNT ON

DECLARE csr CURSOR FAST_FORWARD READ_ONLY
FOR
SELECT name
FROM sys.databases

CREATE TABLE ##loginfo
(
 dbname varchar(100),
 num_of_rows int)

OPEN csr

FETCH NEXT FROM csr INTO @dbname

WHILE (@@fetch_status <> -1)
BEGIN

CREATE TABLE #log_info
(
 RecoveryUnitId tinyint,
 fileid tinyint,
 file_size bigint,
 start_offset bigint,
 FSeqNo int,
[status] tinyint,
 parity tinyint,
 create_lsn numeric(25,0)
)

SET @query = 'DBCC loginfo (' + '''' + @dbname + ''') '

INSERT INTO #log_info
EXEC (@query)

SET @count = @@rowcount

DROP TABLE #log_info

INSERT ##loginfo
VALUES(@dbname, @count)

FETCH NEXT FROM csr INTO @dbname

END

CLOSE csr
DEALLOCATE csr

SELECT dbname,
 num_of_rows
FROM ##loginfo
WHERE num_of_rows >= 50 --My rule of thumb is 50 VLFs. Your mileage may vary.
ORDER BY dbname

DROP TABLE ##loginfo