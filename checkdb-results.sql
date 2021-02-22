USE [master]
GO

SELECT [instance]
      ,[database]
      ,[size]
      ,[result]
      ,[checkdb_type]
      ,[data_collection_timestamp]
      ,[completion_time] AS seconds
      ,[last_good_dbcc]
  FROM [dbo].[CheckDB]
UNION ALL
SELECT [instance]
      ,[database]
      ,[size]
      ,[result]
      ,[checkdb_type]
      ,[data_collection_timestamp]
      ,[completion_time] AS seconds
      ,[last_good_dbcc]
  FROM [EMSSQL3].master.[dbo].[CheckDB]
UNION ALL
SELECT [instance]
      ,[database]
      ,[size]
      ,[result]
      ,[checkdb_type]
      ,[data_collection_timestamp]
      ,[completion_time] AS seconds
      ,[last_good_dbcc]
  FROM [EMSSQL7].master.[dbo].[CheckDB]
ORDER BY instance, [database]


