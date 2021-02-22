declare @schema nvarchar(255)
declare @table nvarchar(255)
declare @col nvarchar(255)
declare @dtype nvarchar(255)
declare @sql nvarchar(max)

declare maxcols cursor for
select
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE
from
INFORMATION_SCHEMA.COLUMNS c
inner join INFORMATION_SCHEMA.TABLES t on
    c.TABLE_CATALOG = t.TABLE_CATALOG
    and c.TABLE_SCHEMA = t.TABLE_SCHEMA
    and c.TABLE_NAME = t.TABLE_NAME
    and t.TABLE_TYPE = 'BASE TABLE'
where
    c.DATA_TYPE = 'timestamp'
ORDER BY t.TABLE_NAME
    --and c.CHARACTER_MAXIMUM_LENGTH = -1

open maxcols

fetch next from maxcols into @schema, @table, @col, @dtype

while @@FETCH_STATUS = 0
begin
    set @sql = 'alter table [' + @schema + '].[' + @table + 
        '] alter column [' + @col + '] ' + 'binary(8)'
    exec sp_executesql @sql

    fetch next from maxcols into @schema, @table, @col, @dtype
end