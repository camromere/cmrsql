-----------------BEGIN: Script to be run at Publisher 'EMSSQL4'-----------------
use [RCSQL]
exec sp_addsubscription @publication = N'RCSQL_Publication', @subscriber = N'emssql3', @destination_db = N'RCSQL', @sync_type = N'Automatic', @subscription_type = N'pull', @update_mode = N'read only'
GO
-----------------END: Script to be run at Publisher 'EMSSQL4'-----------------

-----------------BEGIN: Script to be run at Subscriber 'emssql3'-----------------
use [RCSQL]
exec sp_addpullsubscription @publisher = N'EMSSQL4', @publication = N'RCSQL_Publication', @publisher_db = N'RCSQL', @independent_agent = N'True', @subscription_type = N'pull', @description = N'', @update_mode = N'read only', @immediate_sync = 0

exec sp_addpullsubscription_agent @publisher = N'EMSSQL4', @publisher_db = N'RCSQL', @publication = N'RCSQL_Publication', @distributor = N'EMSSQL4', @distributor_security_mode = 1, @distributor_login = N'', @distributor_password = null, @enabled_for_syncmgr = N'False', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 0, @active_start_date = 0, @active_end_date = 19950101, @alt_snapshot_folder = N'', @working_directory = N'', @use_ftp = N'False', @job_login = N'emsmc\sql', @job_password = null, @publication_type = 0
GO
-----------------END: Script to be run at Subscriber 'emssql3'-----------------

