/*This will script out the command for you, check it and execute the output */

SELECT 'ALTER DATABASE ' + QUOTENAME(s.name) + ' SET PAGE_VERIFY CHECKSUM  WITH NO_WAIT;'
FROM sys.databases AS s
WHERE s.page_verify_option_desc <> 'CHECKSUM';
GO

SELECT name, page_verify_option FROM sys.databases;