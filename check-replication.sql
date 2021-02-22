EXECUTE sp_replmonitorsubscriptionpendingcmds 
@publisher ='EMSSQL4', -- Put publisher server name here
@publisher_db = 'RCSQL', -- Put publisher database name here
@publication ='RCSQL_Publication',  -- Put publication name here
@subscriber ='EMSSQL3', -- Put subscriber server name here
@subscriber_db ='RCSQL', -- Put subscriber database name here
@subscription_type ='0' -- 0 = push and 1 = pull 

EXECUTE sp_replmonitorsubscriptionpendingcmds 
@publisher ='EMSSQL4', -- Put publisher server name here
@publisher_db = 'RCSQL', -- Put publisher database name here
@publication ='RCSQL_Publication',  -- Put publication name here
@subscriber ='EMSSQL7', -- Put subscriber server name here
@subscriber_db ='RCSQL', -- Put subscriber database name here
@subscription_type ='0' -- 0 = push and 1 = pull 