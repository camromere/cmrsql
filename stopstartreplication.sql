--STOP the Distribution Agent:
exec distribution.dbo.sp_MSstopdistribution_agent 
@publisher  = 'EMSSQL4',
@publisher_db   = 'RCSQL',
@publication    = 'RCSQL_Publication',
@subscriber     = 'EMSSQL3',
@subscriber_db  = 'RCSQL';

exec distribution.dbo.sp_MSstartdistribution_agent 
@publisher  = 'EMSSQL4',
@publisher_db   = 'RCSQL',
@publication    = 'RCSQL_Publication',
@subscriber     = 'EMSSQL3',
@subscriber_db  = 'RCSQL'