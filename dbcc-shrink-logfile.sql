SELECT recovery_model_desc FROM sys.databases WHERE name = 'RCSQL' --Before

ALTER DATABASE RCSQL SET recovery simple

SELECT recovery_model_desc FROM sys.databases WHERE name = 'RCSQL' --After

EXEC xp_fixeddrives --Check free drive space 

EXEC sp_helpdb RCSQL -- Note the size of the log before shrink

DBCC shrinkfile(RCSQLLog, 100000) -- shrink log to 1 GB

EXEC sp_helpdb RCSQL -- Note the size of the log after shrink

EXEC xp_fixeddrives -- Check free drive space 