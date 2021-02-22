SELECT TOP 100 * FROM alert.Alert_Summary WHERE TargetObject LIKE '%xml_deadlock_report%'

SELECT TargetObject, [Read],
                             (SELECT        TOP (1) Date
                               FROM            alert.Alert_Severity AS s
                               WHERE        (alert.Alert.AlertId = AlertId)
                               ORDER BY Date DESC) AS LastUpdate,
                             (SELECT        MAX(Severity) AS Expr1
                               FROM            alert.Alert_Severity AS s
                               WHERE        (alert.Alert.AlertId = AlertId)) AS WorstSeverity, Cleared
FROM            alert.Alert


SELECT AlertId, dateadd(s,convert(bigint, Date)/1000,convert(datetime, '1-1-1970 00:00:00')), Severity FROM alert.Alert_Severity AS s

select dateadd(s, convert(bigint, 1283174502729) / 1000, convert(datetime, '1-1-1970 00:00:00'))


SELECT s.name, se.event_name
FROM sys.dm_xe_sessions s
       INNER JOIN sys.dm_xe_session_events se ON (s.address = se.event_session_address) and (event_name = 'xml_deadlock_report')
WHERE name = 'system_health'

--DECLARE @version int
--SET @version = (@@microsoftversion / 0x1000000) & 0xff;
--IF (@version = 10)
--BEGIN
--WITH SystemHealth
--AS (
--SELECT CAST(target_data as xml) AS TargetData
--FROM sys.dm_xe_session_targets st
--       JOIN sys.dm_xe_sessions s ON s.address = st.event_session_address
--WHERE name = 'system_health'
--       AND st.target_name = 'ring_buffer')
--SELECT XEventData.XEvent.value('(data/value)[1]','VARCHAR(MAX)') AS DeadLockGraph
--FROM SystemHealth
--       CROSS APPLY TargetData.nodes('//RingBufferTarget/event') AS XEventData (XEvent)
--WHERE XEventData.XEvent.value('@name','varchar(4000)') = 'xml_deadlock_report'
END




SELECT TOP 10 target_data FROM sys.dm_xe_session_targets
SELECT TOP 10 * FROM sys.dm_xe_sessions

SELECT CONVERT(xml, event_data).query('/event/data/value/child::*'),
       CONVERT(xml, event_data).value('(event[@name="xml_deadlock_report"]/@timestamp)[1]','datetime') as Execution_Time
FROM sys.fn_xe_file_target_read_file('C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Log\system_health*.xel', null, null, null)
WHERE object_name like 'xml_deadlock_report'


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