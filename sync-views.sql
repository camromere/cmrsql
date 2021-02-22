DECLARE @sourceDB NVARCHAR(128);
DECLARE @viewsDB NVARCHAR(128);
SET @sourceDB = 'RCSQL';
SET @viewsDB = 'RCSQL_Views';

SELECT *
FROM RCSQL.sys.all_objects AS O1
INNER JOIN RCSQL_Views.sys.schemas AS S1 ON O1.schema_id = S1.schema_id
FULL OUTER JOIN RCSQL_Views.sys.all_objects O2 ON O1.name = O2.name
WHERE S1.name='dbo' and O1.is_ms_shipped = 0 
and (O1.Type in ('FN','P','TF','V')) and (O2.object_id IS NULL)
