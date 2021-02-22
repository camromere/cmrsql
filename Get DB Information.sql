USE master

/*
CREATED BY: Carla Romere
DATE:       08.21.2018
PURPOSE:    View of database size and backup verification
*/

--CREATE VIEW dbaSizeBackupList

SELECT @@SERVERNAME Servername,
CONVERT(VARCHAR(25), DB.name) AS dbName,
CONVERT(VARCHAR(10), DATABASEPROPERTYEX(name, 'status')) AS [Status],
--(SELECT COUNT(1) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid !=0 ) AS DataFiles,
(SELECT SUM((size*8)/1024) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0) AS [Data MB],
--(SELECT COUNT(1) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) AS LogFiles,
(SELECT SUM((size*8)/1024) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) AS [Log MB],
(SELECT SUM((size*8)/1024) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid!=0)+(SELECT SUM((size*8)/1024) FROM sys.sysaltfiles WHERE DB_NAME(dbid) = DB.name AND groupid=0) TotalSizeMB,
--convert(sysname,DatabasePropertyEx(name,'Updateability'))  Updateability,
--convert(sysname,DatabasePropertyEx(name,'UserAccess')) UserAccess ,
convert(sysname,DatabasePropertyEx(name,'Recovery')) RecoveryModel ,
convert(sysname,DatabasePropertyEx(name,'Version')) Version ,
--CASE COMPATIBILITY_LEVEL 
--WHEN 60 THEN '60 (SQL Server 6.0)'
--WHEN 65 THEN '65 (SQL Server 6.5)'
--WHEN 70 THEN '70 (SQL Server 7.0)'
--WHEN 80 THEN '80 (SQL Server 2000)'
--WHEN 90 THEN '90 (SQL Server 2005)'
--WHEN 100 THEN '100 (SQL Server 2008)'
--END AS [compatibility level],
CONVERT(VARCHAR(20),  create_date, 103) + ' ' + CONVERT(VARCHAR(20), create_date, 108) AS [Creation date]
--ISNULL((SELECT TOP 1
--CASE TYPE WHEN 'D' THEN 'Full' WHEN 'I' THEN 'Differential' WHEN 'L' THEN 'Transaction log' END + ' – ' +
--LTRIM(ISNULL(STR(ABS(DATEDIFF(DAY, GETDATE(),Backup_finish_date))) + ' days ago', 'NEVER')) + ' – ' +
--CONVERT(VARCHAR(20), backup_start_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_start_date, 108) + ' – ' +
--CONVERT(VARCHAR(20), backup_finish_date, 103) + ' ' + CONVERT(VARCHAR(20), backup_finish_date, 108) +
--' (' + CAST(DATEDIFF(second, BK.backup_start_date,
--BK.backup_finish_date) AS VARCHAR(4)) + ' '+ 'seconds)'
FROM msdb.dbo.backupset BK WHERE BK.database_name = DB.name ORDER BY backup_set_id DESC),'-') AS [Last backup]
FROM sys.databases DB
ORDER BY dbName, [Last backup] DESC, NAME

--SELECT * FROM msdb.dbo.backupset WHERE name LIKE '%backup%'
--SELECT * FROM msdb.dbo.sysjobactivity;
--SELECT * FROM msdb.dbo.sysjobsteps;
--SELECT * FROM msdb.dbo.sysjobs;

SELECT name,
CASE WHEN name IN('RCSQL-Full-Backup','RCSQL Diff backup') THEN 'RCSQL'
	 WHEN name IN('Backup Dev-Simx.Subplan_1','Diff Backup Dev-Simx.Subplan_1') THEN 'EMSmart_Dev_Simx'
	 WHEN name IN('Backup Full RCSQL_Views') THEN 'RCSQL_Views'
	 WHEN name IN('PPAPI_Full_backup','PPAPI_Diff_backup.Back Up Database (Differential)') THEN 'PPAPI'
	 WHEN name IN('HDSQL_Full_Backup','HDSQL_Diff_Backup') THEN 'HDSQL'
	 WHEN name IN('CustomSolutions_Full_backup','CustomSolutions_Diff_backup.Subplan_1') THEN 'CustomSolutions'
	 WHEN name IN('Full Forms backup','Diff Forms backup') THEN 'FORMS'
	 WHEN name IN('Zoll Static Data Full backup') THEN 'Zoll Static Data'
	 WHEN name IN('System Databases Full backup') THEN 'System Databases'
	 WHEN name IN('EMSmart Dev Simx Reprocess Full backup') THEN 'EMSmart Dev Simx Reprocess'
	 WHEN name IN('RNB_Sup Full Backup') THEN 'RNB_Sup'
END AS dbName,
CASE WHEN name LIKE '%full%' THEN 'Full'
	 WHEN name LIKE '%diff%' THEN 'Differential'
END AS BackupType,
CASE freq_type
WHEN 4 THEN 'Daily'
WHEN 8 THEN 'Weekly'
END AS Frequency,
freq_interval, freq_subday_type, freq_recurrence_factor, active_start_time, 
'Start_Date' = substring(convert(varchar(15),active_start_date),1,4) 
        + '/' + substring(convert(varchar(15),active_start_date),5,2) + '/'
        + substring(convert(varchar(15),active_start_date),7,2)
        + ' ' + 
        case len(active_start_time)
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
        end
FROM msdb.dbo.sysschedules
WHERE name LIKE '%backup%'
ORDER BY dbName, BackupType;

/* JOB INFORMATION */
SELECT 
    [sJOB].[job_id] AS [JobID]
    , [sJOB].[name] AS [JobName]
    , [sDBP].[name] AS [JobOwner]
    , [sCAT].[name] AS [JobCategory]
    , [sJOB].[description] AS [JobDescription]
    , CASE [sJOB].[enabled]
        WHEN 1 THEN 'Yes'
        WHEN 0 THEN 'No'
      END AS [IsEnabled]
    , [sJOB].[date_created] AS [JobCreatedOn]
    , [sJOB].[date_modified] AS [JobLastModifiedOn]
    , [sSVR].[name] AS [OriginatingServerName]
    , [sJSTP].[step_id] AS [JobStartStepNo]
    , [sJSTP].[step_name] AS [JobStartStepName]
    , CASE
        WHEN [sSCH].[schedule_uid] IS NULL THEN 'No'
        ELSE 'Yes'
      END AS [IsScheduled]
    , [sSCH].[schedule_uid] AS [JobScheduleID]
    , [sSCH].[name] AS [JobScheduleName]
    , CASE [sJOB].[delete_level]
        WHEN 0 THEN 'Never'
        WHEN 1 THEN 'On Success'
        WHEN 2 THEN 'On Failure'
        WHEN 3 THEN 'On Completion'
      END AS [JobDeletionCriterion]
FROM
    [msdb].[dbo].[sysjobs] AS [sJOB]
    LEFT JOIN [msdb].[sys].[servers] AS [sSVR]
        ON [sJOB].[originating_server_id] = [sSVR].[server_id]
    LEFT JOIN [msdb].[dbo].[syscategories] AS [sCAT]
        ON [sJOB].[category_id] = [sCAT].[category_id]
    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sJSTP]
        ON [sJOB].[job_id] = [sJSTP].[job_id]
        AND [sJOB].[start_step_id] = [sJSTP].[step_id]
    LEFT JOIN [msdb].[sys].[database_principals] AS [sDBP]
        ON [sJOB].[owner_sid] = [sDBP].[sid]
    LEFT JOIN [msdb].[dbo].[sysjobschedules] AS [sJOBSCH]
        ON [sJOB].[job_id] = [sJOBSCH].[job_id]
    LEFT JOIN [msdb].[dbo].[sysschedules] AS [sSCH]
        ON [sJOBSCH].[schedule_id] = [sSCH].[schedule_id]
ORDER BY [JobName]

--SELECT 
--    [sJOB].[job_id] AS [JobID]
--    , [sJOB].[name] AS [JobName]
--    , CASE 
--        WHEN [sJOBH].[run_date] IS NULL OR [sJOBH].[run_time] IS NULL THEN NULL
--        ELSE CAST(
--                CAST([sJOBH].[run_date] AS CHAR(8))
--                + ' ' 
--                + STUFF(
--                    STUFF(RIGHT('000000' + CAST([sJOBH].[run_time] AS VARCHAR(6)),  6)
--                        , 3, 0, ':')
--                    , 6, 0, ':')
--                AS DATETIME)
--      END AS [LastRunDateTime]
--    , CASE [sJOBH].[run_status]
--        WHEN 0 THEN 'Failed'
--        WHEN 1 THEN 'Succeeded'
--        WHEN 2 THEN 'Retry'
--        WHEN 3 THEN 'Canceled'
--        WHEN 4 THEN 'Running' -- In Progress
--      END AS [LastRunStatus]
--    , STUFF(
--            STUFF(RIGHT('000000' + CAST([sJOBH].[run_duration] AS VARCHAR(6)),  6)
--                , 3, 0, ':')
--            , 6, 0, ':') 
--        AS [LastRunDuration (HH:MM:SS)]
--    , [sJOBH].[message] AS [LastRunStatusMessage]
--    , CASE [sJOBSCH].[NextRunDate]
--        WHEN 0 THEN NULL
--        ELSE CAST(
--                CAST([sJOBSCH].[NextRunDate] AS CHAR(8))
--                + ' ' 
--                + STUFF(
--                    STUFF(RIGHT('000000' + CAST([sJOBSCH].[NextRunTime] AS VARCHAR(6)),  6)
--                        , 3, 0, ':')
--                    , 6, 0, ':')
--                AS DATETIME)
--      END AS [NextRunDateTime]
--FROM 
--    [msdb].[dbo].[sysjobs] AS [sJOB]
--    LEFT JOIN (
--                SELECT
--                    [job_id]
--                    , MIN([next_run_date]) AS [NextRunDate]
--                    , MIN([next_run_time]) AS [NextRunTime]
--                FROM [msdb].[dbo].[sysjobschedules]
--                GROUP BY [job_id]
--            ) AS [sJOBSCH]
--        ON [sJOB].[job_id] = [sJOBSCH].[job_id]
--    LEFT JOIN (
--                SELECT 
--                    [job_id]
--                    , [run_date]
--                    , [run_time]
--                    , [run_status]
--                    , [run_duration]
--                    , [message]
--                    , ROW_NUMBER() OVER (
--                                            PARTITION BY [job_id] 
--                                            ORDER BY [run_date] DESC, [run_time] DESC
--                      ) AS RowNumber
--                FROM [msdb].[dbo].[sysjobhistory]
--                WHERE [step_id] = 0
--            ) AS [sJOBH]
--        ON [sJOB].[job_id] = [sJOBH].[job_id]
--        AND [sJOBH].[RowNumber] = 1
--ORDER BY [JobName]

--SELECT
--    [sJOB].[job_id] AS [JobID]
--    , [sJOB].[name] AS [JobName]
--    , [sJSTP].[step_uid] AS [StepID]
--    , [sJSTP].[step_id] AS [StepNo]
--    , [sJSTP].[step_name] AS [StepName]
--    , CASE [sJSTP].[subsystem]
--        WHEN 'ActiveScripting' THEN 'ActiveX Script'
--        WHEN 'CmdExec' THEN 'Operating system (CmdExec)'
--        WHEN 'PowerShell' THEN 'PowerShell'
--        WHEN 'Distribution' THEN 'Replication Distributor'
--        WHEN 'Merge' THEN 'Replication Merge'
--        WHEN 'QueueReader' THEN 'Replication Queue Reader'
--        WHEN 'Snapshot' THEN 'Replication Snapshot'
--        WHEN 'LogReader' THEN 'Replication Transaction-Log Reader'
--        WHEN 'ANALYSISCOMMAND' THEN 'SQL Server Analysis Services Command'
--        WHEN 'ANALYSISQUERY' THEN 'SQL Server Analysis Services Query'
--        WHEN 'SSIS' THEN 'SQL Server Integration Services Package'
--        WHEN 'TSQL' THEN 'Transact-SQL script (T-SQL)'
--        ELSE sJSTP.subsystem
--      END AS [StepType]
--    , [sPROX].[name] AS [RunAs]
--    , [sJSTP].[database_name] AS [Database]
--    , [sJSTP].[command] AS [ExecutableCommand]
--    , CASE [sJSTP].[on_success_action]
--        WHEN 1 THEN 'Quit the job reporting success'
--        WHEN 2 THEN 'Quit the job reporting failure'
--        WHEN 3 THEN 'Go to the next step'
--        WHEN 4 THEN 'Go to Step: ' 
--                    + QUOTENAME(CAST([sJSTP].[on_success_step_id] AS VARCHAR(3))) 
--                    + ' ' 
--                    + [sOSSTP].[step_name]
--      END AS [OnSuccessAction]
--    , [sJSTP].[retry_attempts] AS [RetryAttempts]
--    , [sJSTP].[retry_interval] AS [RetryInterval (Minutes)]
--    , CASE [sJSTP].[on_fail_action]
--        WHEN 1 THEN 'Quit the job reporting success'
--        WHEN 2 THEN 'Quit the job reporting failure'
--        WHEN 3 THEN 'Go to the next step'
--        WHEN 4 THEN 'Go to Step: ' 
--                    + QUOTENAME(CAST([sJSTP].[on_fail_step_id] AS VARCHAR(3))) 
--                    + ' ' 
--                    + [sOFSTP].[step_name]
--      END AS [OnFailureAction]
--FROM
--    [msdb].[dbo].[sysjobsteps] AS [sJSTP]
--    INNER JOIN [msdb].[dbo].[sysjobs] AS [sJOB]
--        ON [sJSTP].[job_id] = [sJOB].[job_id]
--    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sOSSTP]
--        ON [sJSTP].[job_id] = [sOSSTP].[job_id]
--        AND [sJSTP].[on_success_step_id] = [sOSSTP].[step_id]
--    LEFT JOIN [msdb].[dbo].[sysjobsteps] AS [sOFSTP]
--        ON [sJSTP].[job_id] = [sOFSTP].[job_id]
--        AND [sJSTP].[on_fail_step_id] = [sOFSTP].[step_id]
--    LEFT JOIN [msdb].[dbo].[sysproxies] AS [sPROX]
--        ON [sJSTP].[proxy_id] = [sPROX].[proxy_id]
--ORDER BY [JobName], [StepNo]

--select
--     'Job ID' = j.job_id
--    ,'Job Name' = j.name
--    ,'Job Enabled' = case j.enabled
--            when 1 then 'Yes'
--            else 'No'
--        end
--    ,'Frequency' = case s.freq_type 
--        when 1 then 'One time only'
--        when 4 then 'Daily'
--        when 8 then 'Weekly'
--        when 16 then 'Monthly'
--        when 32 then 'Monthly, relative to freq_interval'
--        when 64 then 'Runs when the SQL Server Agent service starts'
--        when 128 then 'Runs when the computer is idle'
--    end
--    ,'Interval' = case s.freq_subday_type
--        when 1 then 'At specified time'
--        when 2 then CAST(freq_subday_interval AS VARCHAR(3)) + ' Seconds'
--        when 4 then CAST(freq_subday_interval AS VARCHAR(3)) + ' Minutes'
--        when 8 then CAST(freq_subday_interval AS VARCHAR(3)) + ' Hours'
--    end
--    ,'Start_Date' = substring(convert(varchar(15),active_start_date),1,4) 
--        + '/' + substring(convert(varchar(15),active_start_date),5,2) + '/'
--        + substring(convert(varchar(15),active_start_date),7,2)
--        + ' ' + 
--        case len(active_start_time)
--            when 1 then cast('00:00:0' + right(active_start_time,2) as char(8))
--            when 2 then cast('00:00:' + right(active_start_time,2) as char(8))
--            when 3 then cast('00:0'
--                    + left(right(active_start_time,3),1)  
--                    +':' + right(active_start_time,2) as char (8))
--            when 4 then cast('00:'
--                    + left(right(active_start_time,4),2)  
--                    +':' + right(active_start_time,2) as char (8))
--            when 5 then cast('0'
--                    + left(right(active_start_time,5),1) 
--                    +':' + Left(right(active_start_time,4),2)  
--                    +':' + right(active_start_time,2) as char (8))
--            when 6 then cast(Left(right(active_start_time,6),2) 
--                    +':' + Left(right(active_start_time,4),2)  
--                    +':' + right(active_start_time,2) as char (8))
--        end
--    ,'Schedule Enabled' = case s.enabled
--            when 1 then 'Yes'
--            else 'No'
--        end
--    ,'Schedule Desc' = s.name
--from msdb.dbo.sysjobs j
--inner join msdb.dbo.sysjobschedules js
--on j.job_id = js.job_id
--inner join msdb.dbo.sysschedules s
--on s.schedule_id = js.schedule_id
--order by j.name
--GO

SELECT
    d.name AS 'Database',
    m.name AS 'File',
    m.size,
    m.size * 8/1024 'Size (MB)',
    SUM(m.size * 8/1024) OVER (PARTITION BY d.name) AS 'Database Total'
    --,m.max_size
FROM sys.master_files m
INNER JOIN sys.databases d ON
d.database_id = m.database_id;