USE RNB_Sup --emssql3 --Make sure to add the current date as the last column

/* 
REPLACE ALL COMMAS WITHIN FIELDS WITH |
MAKE SURE THERE ARE NO QUOTES LEFT
Save modified csv file to \\emssql3\b$\insert_ScheduleEventCategory.csv
SELECT * FROM dbo.ScheduleEventCategory Save backup of existing data on 2nd worksheet
*/
--SELECT 'BEFORE TRUNCATE' AS STAT, COUNT(*) from dbo.ScheduleEventCategory;

--TRUNCATE TABLE dbo.ScheduleEventCategory;

--SELECT 'AFTER TRUNCATE' AS STAT, COUNT(*) from dbo.ScheduleEventCategory;
SELECT 'BEFORE INSERT' AS STAT, COUNT(*) from dbo.ScheduleEventCategory

BULK INSERT dbo.ScheduleEventCategory
FROM 'b:\insert_ScheduleEventCategory.csv'
WITH
	(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
GO

SELECT 'AFTER INSERT' AS STAT, COUNT(*) from dbo.ScheduleEventCategory
SELECT * FROM dbo.ScheduleEventCategory