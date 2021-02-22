EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'AdminAccount',
@recipients = 'carla.romere@emsbilling.com',
@subject = 'EMSmart Dev Refresh from Prod Results',
@query = N'SELECT ''Production'' AS ENV, MAX(tdate) AS LAST_DATE, COUNT(*) AS TRIPS FROM [EMSmart].dbo.trip WHERE tdate<=GETDATE()
UNION ALL
SELECT ''Dev'' AS ENV, MAX(tdate) AS LAST_DATE, COUNT(*) AS TRIPS FROM [EMSmart_Dev].dbo.trip WHERE tdate<=GETDATE();',
@attach_query_result_as_file = 0
