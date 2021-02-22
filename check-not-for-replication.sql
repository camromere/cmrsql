DECLARE @cmd varchar(max) = ''

SELECT obj.name, *
-- @cmd = @cmd + 'alter table [' + object_schema_name( col.object_id ) + '].[' + object_name( col.object_id ) + '] alter column [' + col.name + '] add not for replication; '
FROM sys.identity_columns as col
 INNER JOIN sys.objects as obj on obj.object_id = col.object_id
WHERE
 obj.is_ms_shipped = 0 and is_not_for_replication = 0

SELECT @cmd
EXEC (@cmd)


select name,is_not_for_replication,* from sys.triggers where is_ms_shipped = 0
SELECT * FROM sys.tables where object_id=1588460983