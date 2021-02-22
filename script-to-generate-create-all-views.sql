SELECT SM.object_id, Views.name, SM.definition
FROM sys.sql_modules SM
INNER JOIN sys.Objects SO
ON SM.Object_id = SO.Object_id
INNER JOIN sys.views Views
ON SO.Object_id=Views.object_id
WHERE SO.type = 'V'
AND Views.name IN()
