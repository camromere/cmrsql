SELECT DB_NAME(database_id) as [DB]
    , login_name
    , nt_domain
    , nt_user_name
    , status
    , host_name
    , program_name
    , COUNT(*) AS [Connections]
FROM sys.dm_exec_sessions
WHERE database_id > 4 -- OR 4 for user DBs
GROUP BY database_id, status, nt_domain, nt_user_name, login_name, host_name, program_name
ORDER BY DB