IF OBJECT_ID('tempdb..#dlcount') IS NOT NULL
    DROP TABLE #dlcount;
BEGIN
WITH SystemHealth
AS (
SELECT CAST(target_data as xml) AS TargetData, CAST(s.create_time AS DATE) AS create_time
FROM sys.dm_xe_session_targets st
       JOIN sys.dm_xe_sessions s ON s.address = st.event_session_address
WHERE name = 'system_health'
AND st.target_name = 'ring_buffer'
AND s.create_time > '2021-01-01')
SELECT create_time, XEventData.XEvent.query('(data/value/deadlock)[1]') AS DeadLockGraph
INTO #dlcount
FROM SystemHealth
       CROSS APPLY TargetData.nodes('//RingBufferTarget/event') AS XEventData (XEvent)
WHERE XEventData.XEvent.value('@name','varchar(4000)') = 'xml_deadlock_report'

SELECT create_time, COUNT(DeadLockGraph) AS total_deadlocks
FROM #dlcount
GROUP BY create_time
END
SELECT * FROM #dlcount