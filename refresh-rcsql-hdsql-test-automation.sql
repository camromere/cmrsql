USE master; 
ALTER DATABASE RCSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

PRINT 'Start the copy of the backup to testsqlrnr at ' + cast(getdate() as varchar(20)) +'.';

Exec xp_cmdshell 'ROBOCOPY "\\emsawssgw1.emsmc.local\sgw1-sqlbackup\emssql4\full\replication" "\\testsqlrnr.test.local\b$\RepBackups" rcsql-full-4replication-20200314.sqb';

EXECUTE master..sqlbackup '-SQL "RESTORE DATABASE [RCSQL] FROM DISK = ''B:\RepBackups\rcsql-full-4replication-20200314.sqb'' WITH PASSWORD = ''DGdUDM3C5yxlwuexalIl4Dp75K3sEh'', RECOVERY, DISCONNECT_EXISTING, MOVE ''RCSQL'' TO ''D:\RCSQL\RCSQL.mdf'', MOVE ''RCSQLLog'' TO ''L:\RCSQL\RCSQLLog.ldf'', REPLACE, ORPHAN_CHECK"';

EXECUTE master..sqlbackup '-SQL "RESTORE DATABASE [HDSQL] FROM DISK = ''B:\RepBackups\rcsql-full-4replication-20200314.sqb'' WITH PASSWORD = ''DGdUDM3C5yxlwuexalIl4Dp75K3sEh'', RECOVERY, DISCONNECT_EXISTING, MOVE ''RCSQL'' TO ''D:\RCSQL\RCSQL.mdf'', MOVE ''RCSQLLog'' TO ''L:\RCSQL\RCSQLLog.ldf'', REPLACE, ORPHAN_CHECK"';

