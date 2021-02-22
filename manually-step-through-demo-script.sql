EXEC [dbo].[usp_emsight_demo_process_starting];
PRINT 'Initial email sent.';

PRINT 'Starting to populate the initial tables.';
EXEC [mask].[usp_populate_mask_tables];
PRINT 'Initial tables populated.';

SELECT TOP 10 * FROM mask.Customers;
SELECT TOP 10 * FROM mask.Customer_Payors;

PRINT 'Starting to mask the data.';
GO
Exec xp_cmdshell '"C:\Program Files\Red Gate\Data Masker for SQL Server 7\DataMaskerCmdLine.exe" PARFILE=C:\DataMaskerProjects\EDW_Demo\emssql7-rcsql-parfile.txt';
PRINT 'Data should be masked - verify here.';
GO

SELECT TOP 10 * FROM mask.Customers;
SELECT TOP 10 * FROM mask.Customer_Payors;

EXEC [demo].[usp_populate_customers_customer_payors_with_masked_data];
EXEC [demo].usp_populate_demo_tables;
UPDATE demo.Notes SET Description = (SELECT demo.udf_get_random_comment());
EXEC [EDW].demo.usp_populate_EDW_demo_tables;
EXEC('CALL emsight_prod.usp_truncate_demo_masked_data') AT [EMSIGHT_PROD_MYSQL];
EXEC [RCSQL].demo.usp_populate_masked_data_table;
EXEC('CALL emsight_prod.usp_populate_demo_data') AT [EMSIGHT_PROD_MYSQL];
EXEC('CALL emsight_prod.usp_update_masked_data_emsight') AT [EMSIGHT_PROD_MYSQL];
EXEC [dbo].[usp_emsight_demo_process_finished];