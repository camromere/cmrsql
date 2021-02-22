SELECT * FROM sys.dm_db_index_physical_stats ((SELECT dbid FROM sysdatabases WHERE name='EMSmart'),NULL, NULL, NULL, NULL)
ORDER BY avg_fragmentation_in_percent desc
