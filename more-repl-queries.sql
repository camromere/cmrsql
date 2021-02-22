--SELECT * from sys.dm_os_waiting_tasks ORDER BY wait_duration_ms DESC
--select * From distribution.dbo.msdistribution_status

declare @xact_seqno varbinary(16)
select @xact_seqno = max(xact_seqno) from MSsubscriptions
inner join MSpublications
on MSpublications.publication_id = MSsubscriptions.publication_id
inner join MSdistribution_history
on MSdistribution_history.agent_id = MSsubscriptions.agent_id
Where subscriber_db = 'RCSQL'
AND Publication = 'RCSQL_Publication'
Print @xact_seqno

declare @str varchar(255)
set @str = master.dbo.fn_varbintohexstr (@xact_seqno)
set @str = left(@str, len(@str)-8)

IF OBJECT_ID('tempdb..#trancommands') IS NOT NULL
    DROP TABLE #trancommands;

create table #trancommands
(xact_seqno varbinary(16) null,
originator_srvname sysname null,
originator_db sysname null,
article_id int null,
type int null,
partial_command bit null,
hashkey int null,
originator_publication_id int null,
originator_db_version int null,
originator_lsn varbinary(16) null,
command nvarchar(1024) null,
command_id int) 
insert into #trancommands
exec sp_browsereplcmds @xact_seqno_start = @str
select * from #trancommands where xact_seqno > @xact_seqno

SELECT COUNT(*) FROM distribution.dbo.MSrepl_commands

set transaction isolation level read uncommitted
select distinct 
srv.srvname publication_server 
, a.publisher_db
, p.publication publication_name
, p.retention
, ss.srvname subscription_server
, s.subscriber_db
from MSArticles a 
join MSpublications p on a.publication_id = p.publication_id
join MSsubscriptions s on p.publication_id = s.publication_id
join master..sysservers ss on s.subscriber_id = ss.srvid
join master..sysservers srv on srv.srvid = p.publisher_id
join MSdistribution_agents da on da.publisher_id = p.publisher_id 
and da.subscriber_id = s.subscriber_id
ORDER BY p.retention 