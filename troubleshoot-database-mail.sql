EXEC msdb.sys.sp_helprolemember 'AdminAccount';
EXEC msdb.dbo.sysmail_help_status_sp;
EXEC msdb.dbo.sysmail_start_sp;
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';
EXEC msdb.dbo.sysmail_stop_sp;
EXEC msdb.dbo.sysmail_start_sp;
select * from msdb.dbo.sysmail_unsentitems;
select * from msdb.dbo.sysmail_sentitems WHERE send_request_date > '2020-02-17';

