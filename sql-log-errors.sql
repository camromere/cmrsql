declare @Time_Start datetime;
declare @Time_End datetime;
set @Time_Start=getdate()-2;
set @Time_End=getdate();

create table #ErrorLog (logdate datetime
                      , processinfo varchar(255)
                      , Message varchar(500) )

insert #ErrorLog (logdate, processinfo, Message)
   EXEC master.dbo.xp_readerrorlog 0, 1, null, null , @Time_Start, @Time_End, N'desc';

create table SQL_Log_Errors (
	[logdate] datetime,
    [Message] varchar (500) )

insert into SQL_Log_Errors 
  select LogDate, Message FROM #ErrorLog
   where (Message LIKE '%error%' OR Message LIKE '%failed%') 
     and processinfo NOT LIKE 'logon'
   order by logdate desc

drop table #ErrorLog

declare @cnt int  
select @cnt=COUNT(1) from SQL_Log_Errors
if (@cnt > 0)
begin

	declare @strsubject varchar(100)
	select @strsubject='There are errors in the SQL Error Log on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>SQL Error Log Errors - ' + @@SERVERNAME + '</H1>' +
		N'<table border="1">' +
		N'<tr><th>Log Date</th>' +
		N'<th>Message</th></tr>' +
		CAST ( ( SELECT td = [logdate], '',
	                    td = [Message]
				  FROM SQL_Log_Errors
				  FOR XML PATH('tr'), TYPE 
		) AS NVARCHAR(MAX) ) +
		N'</table>' ;

	EXEC msdb.dbo.sp_send_dbmail
	@from_address='test@test.com',
	@recipients='test@test.com',
	@subject = @strsubject,
	@body = @tableHTML,
	@body_format = 'HTML' ,
	@profile_name='test profile'
end

drop table SQL_Log_Errors