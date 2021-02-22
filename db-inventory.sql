INSERT INTO [db_inv].dbo.dblist 
SELECT      SERVERPROPERTY('SERVERNAME') AS 'instance',
            sys.databases.name AS 'name',
            CONVERT(INT,SUM(size)*8.0/1024) AS 'size',
            sys.databases.state_desc AS 'state',
            suser_sname(sys.databases.owner_sid) AS 'owner',
            GETDATE() as 'timestamp'
FROM        sys.databases 
JOIN        sys.master_files
ON          sys.databases.database_id = sys.master_files.database_id
WHERE       sys.databases.name NOT IN('master','model','msdb','tempdb','distribution','SDBA')
GROUP BY    sys.databases.name, sys.databases.state_desc,sys.databases.owner_sid
ORDER BY    sys.databases.name