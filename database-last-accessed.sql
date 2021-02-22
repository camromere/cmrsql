select d.name, x1 =
(select X1= max(bb.xx) 
from (
    select xx = max(last_user_seek) 
        where max(last_user_seek) is not null 
    union all 
    select xx = max(last_user_scan) 
        where max(last_user_scan) is not null 
    union all 
    select xx = max(last_user_lookup) 
        where max(last_user_lookup) is not null 
    union all 
        select xx = max(last_user_update) 
        where max(last_user_update) is not null) bb) 
FROM master.dbo.sysdatabases d 
left outer join 
sys.dm_db_index_usage_stats s 
on d.dbid= s.database_id 
group by d.name