;WITH cte AS
(
SELECT GETDATE() AS [Checked Date], 'emsbilling' AS [Database Name], * FROM OPENQUERY(MySQL_ACR64_Prod,'SELECT 
    table_name AS ''Table'', 
    round(((data_length + index_length) / 1024 / 1024), 2) ''Size in MB'' 
FROM information_schema.TABLES 
WHERE table_schema = "emsbilling"
#    AND table_name = "$TABLE_NAME";
ORDER BY round(((data_length + index_length) / 1024 / 1024), 2) DESC')
)

SELECT * FROM cte;