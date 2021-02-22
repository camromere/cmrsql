/*This command will return a row count for each table in your database.*/
 
EXEC sp_MSforeachtable 'SELECT ''?'', Count(*) as NumberOfRows FROM ?';
 
/* Here is how to rebuild all indexes. */
 
 EXEC sp_MSforeachtable @command1="print '?' DBCC DBREINDEX ('?', ' ', 80)"
 
 
/* Here is how you update all statistics on your tables.*/
 
 EXEC sp_MSforeachtable 'UPDATE statistics ? WITH ALL'
 
/* You can also add additional conditional logic if you need to restrict your commands to a subset of tables.
This is very powerful. You don’t always need to hit all tables with a command.
 
This one will loop through all your tables and add the Column CreatedOn on any table that doesn’t already have it. */
 
 EXEC sp_MSforeachtable '
    if not exists (select column_name from INFORMATION_SCHEMA.columns 
                   where table_name = ''?'' and column_name = ''CreatedOn'') 
    begin
        ALTER TABLE [?] ADD CreatedOn datetime NOT NULL DEFAULT getdate();
    end
