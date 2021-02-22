CREATE TABLE #sizes ([name] nvarchar(200), 
-- BOL says (20), but that obviously wrong
             [rowcount] varchar(25))
DECLARE @tablename VARCHAR (128)
 
DECLARE tables CURSOR FOR
   SELECT TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
   order by TABLE_NAME
 
-- Open the cursor
OPEN tables
 
-- Loop through all the tables in the database
FETCH NEXT
   FROM tables
   INTO @tablename
 
WHILE @@FETCH_STATUS = 0
BEGIN
  --print 'Insert into #sizes Select ''' +  @tablename + ''' as [name] ,count(*) from ' + @tablename
  --exec ('Insert into #sizes Select ''' +  @tablename + ''' as [name] ,count(*) from ' + @tablename)
  --faster than select count(*)
  exec ('Insert into #sizes Select ''' +  @tablename + ''' as [name],(SELECT rows FROM sysindexes WHERE id = OBJECT_ID(''' +  @tablename + ''') AND indid < 2)')
FETCH NEXT
   FROM tables
   INTO @tablename
END
 
-- Close and deallocate the cursor
CLOSE tables
DEALLOCATE tables
 
select * from #sizes where name='Notes' Order by [name] 
drop table #sizes
 
/* 
 
.csharpcode, .csharpcode pre
{
font-size: small;
color: black;
font-family: consolas, “Courier New”, courier, monospace;
background-color: #ffffff;
/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
background-color: #f4f4f4;
width: 100%;
margin: 0em;
}
.csharpcode .lnum { color: #606060; }

*/