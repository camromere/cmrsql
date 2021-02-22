
IF OBJECT_ID('tempdb..[#DeadlockData]') IS NOT NULL
    DROP TABLE #DeadlockData;

WITH xml
AS ( SELECT CAST(event_data AS XML) AS XMLDATA
     FROM   sys.fn_xe_file_target_read_file('system_health*.xel', NULL, NULL, NULL) )
SELECT xml.XMLDATA
INTO   #DeadlockData
FROM   xml
WHERE  xml.XMLDATA.value('(/event/@name)[1]', 'varchar(255)') = 'xml_deadlock_report';


WITH death_indeed
AS ( SELECT ca.x.value('@objectname', 'VARCHAR(256)') AS object_name
     FROM   #DeadlockData AS dd
     CROSS APPLY dd.XMLDATA.nodes('//resource-list/*') AS ca(x) )
SELECT   death_indeed.object_name, COUNT_BIG(*) AS deaths
FROM     death_indeed
GROUP BY death_indeed.object_name