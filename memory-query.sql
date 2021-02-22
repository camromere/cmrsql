create table MemoryInfo (
	[Total Memory MB] bigint NOT NULL,
	[Available Memory MB] bigint NOT NULL,
	[% Memory Free] decimal(5,2) NOT NULL)

insert into MemoryInfo
SELECT total_physical_memory_kb/1024 as "Total Memory MB",
       available_physical_memory_kb/1024 as "Available Memory MB",
       available_physical_memory_kb/(total_physical_memory_kb*1.0)*100 AS "% Memory Free"
FROM sys.dm_os_sys_memory

declare @memfree float  
select @memfree=[Available Memory MB] from MemoryInfo    
if (@memfree < 1000)
begin

	declare @strsubject varchar(100)
	select @strsubject='Check memory usage on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>Server Memory Information - ' + @@SERVERNAME +'</H1>' +
		N'<table border="1">' +
		N'<tr><th>TotalMemory MB</th><th>Available Memory MB</th>' +
		N'<th>% Memory Free</th></tr>' +
		CAST ( ( SELECT td = [Total Memory MB], '',
	                    td = [Available Memory MB], '',
	                    td = [% Memory Free]
				  FROM MemoryInfo
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

drop table MemoryInfo