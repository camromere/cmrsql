SELECT [Current LSN], Operation, AllocUnitName, [Rows Deleted], Description, *
FROM fn_dblog(NULL,NULL) 
WHERE 
--[Rows Deleted]>0
--AllocUnitName LIKE 'dbo.trip_transfer_detail%'
OPERATION = 'LOP_BEGIN_XACT'

SELECT 
Operation,
[Transaction Id],
[Transaction SID],
[Transaction Name],
 [Begin Time],
   [SPID],
   Description
FROM fn_dblog (NULL, NULL)
WHERE [Transaction Name] = 'DROPOBJ'
AND [Begin Time] > '2020-11-01'
GO