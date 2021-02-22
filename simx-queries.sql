--[emssql3]
USE EMSmart;


SELECT 'TOTAL IMPORTS IN SIMX' AS DESCRIPTION, COUNT(*) FROM simx_files WHERE Created BETWEEN '08-29-2018' and '08-30-2018'
UNION ALL
SELECT 'TRIP_ID POPULATED' AS DESCRIPTION, COUNT(*) FROM simx_files WHERE Created BETWEEN '08-29-2018' and '08-30-2018' AND Trip_Id IS NOT NULL
UNION ALL
SELECT 'TRIP_ID REMAINING' AS DESCRIPTION, COUNT(*) FROM simx_files WHERE Created BETWEEN '08-29-2018' and '08-30-2018' AND Trip_Id IS NULL

SELECT s.FileId, s.Status, s.Trip_Id, t.id, t.incident_num
FROM simx_files s
FULL OUTER JOIN trip t
ON CAST(s.Trip_Id AS VARCHAR(25))=CAST(t.incident_num AS VARCHAR(25))
WHERE s.Created BETWEEN '09-05-2018' and '09-07-2018'
AND t.created_at BETWEEN '09-05-2018' and '09-07-2018'
ORDER BY t.id

SELECT * FROM trip WHERE incident_num IN('2018-1305')
--AND company_id IN(210,136,25)
--'93183322','93183323','93183401','93183321','93183371','827183402','67604','67603','67609','67610','67612','67611','2018-1288','2018-1292','2018-1286','2018-1296','2018-1300','2018-1301','2018-1303','2018-1305','2018-1306','2018-1308','2018-1312','2018-1311','2018-1315','2018-1318','2018-1319','2018-1324','2018-1330'

SELECT c.* FROM dbo.company c
WHERE c.name in('Care First Inc','Columbus Transport Inc.','Reems Creek Fire Dept')
ORDER BY c.name


SELECT * FROM simx_files WHERE Created BETWEEN '09-05-2018' and '09-07-2018'
AND Trip_Id IS NULL

SELECT * FROM simx_files WHERE Status IN('Error','Logged') AND Created>'2018-10-18'
SELECT DISTINCT Status FROM simx_files

SELECT e.created_at, e.id, e.company_id, e.name, e.created_at, e.epcr 
FROM dbo.emsmart_file e
WHERE e.company_id in(43,90,216)--(210,136,25)
ORDER BY e.Name

SELECT * FROM simx_company_name 
WHERE Name LIKE 'hildrens%'

SELECT * FROM simx_files WHERE FileId=1147727
SELECT id, tdate, customer_id, incident_num, company_id, created_at from trip WHERE incident_num='2039'


/*
UPDATE simx_files SET Status='Done', trip_id=(SELECT id FROM trip WHERE incident_num='0044871') WHERE FileId=1148688
UPDATE  [dbo].[simx_company_name] SET company_id=286216 WHERE id=37

UPDATE  [dbo].[simx_company_name] SET name='Johns Hopkins All Childrens Hospital Critical Care Transport'
WHERE id=149

DELETE FROM [dbo].[simx_company_name] WHERE id IN(125,126,127,128)
*/

/*

USE [EMSmart]
INSERT INTO [dbo].[simx_company_name] ([company_id],[Name]) VALUES(510,'Spotsylvania County Fire & Rescue')

USE [EMSmart_Dev]
INSERT INTO [dbo].[simx_company_name] ([company_id],[Name]) VALUES(286226, 'Durham County Emergency Medical Services')

USE [EMSmart_Stage2]
INSERT INTO [dbo].[simx_company_name] ([company_id],[Name]) VALUES(286226, 'Durham County Emergency Medical Services')

USE [EMSmart]
Update [dbo].[simx_company_name] set name='Maryland Height Fire Protection District'
WHERE company_id=286227

USE [EMSmart_Dev]
Update [dbo].[simx_company_name] set name='Maryland Height Fire Protection District'
WHERE company_id=286227

USE [EMSmart_Stage2]
Update [dbo].[simx_company_name] set name='Maryland Height Fire Protection District'
WHERE company_id=286227

select * from [EMSmart].dbo.company where name like 'Durham %'
select * from EMSmart.dbo.simx_company_name where name like 'Durham %'
select * from [EMSmart_Stage2].dbo.company where name like 'Johns %'
select * from [EMSmart_Dev].dbo.company where name like 'Johns %'

delete from EMSmart.dbo.simx_company_name where id=151

UPDATE [EMSmart_Dev].dbo.company
SET integration_id=437,
location='AGS-AGS-AGS',
epcr='Zoll',
billing_location='AGS',
phone='(800) 814-5339 Ext.',
misc7='2019-07-01',
npi='1053971275',
los_source='emslos',
priority_source='emspriority',
mn_source='emsmn',
email_recipients='[2881]',
import_file_type='pdf',
billing_team='BETA',
monthly_volume='67',
process_icd10=1
WHERE id=286217

*/

                  
/*
USE [EMSmart]
GO
INSERT INTO [dbo].[simx_company_name] ([company_id],[Name])
     VALUES(286183, 'Fenton Fire District')  

	  ‘’ to ‘Danville Life Saving & First Aid Crew Inc’
UPDATE [EMSmart_Stage2].[dbo].[simx_company_name] set Name='Myrtle Beach Fire Department' WHERE Name='Myrtle Beach Fire Rescue'
UPDATE [EMSmart].[dbo].[simx_company_name] set Name='Myrtle Beach Fire Department' WHERE Name='Myrtle Beach Fire Rescue'
UPDATE [EMSmart_Dev].[dbo].[simx_company_name] set Name='Myrtle Beach Fire Department' WHERE Name='Myrtle Beach Fire Rescue'
UPDATE [EMSmart_Dev_simx].[dbo].[simx_company_name] set Name='Danville Life Saving & First Aid Crew Inc' WHERE Name='Danville Life Saving and First Aid Crew'
UPDATE [EMSmart_simx_upgrade].[dbo].[simx_company_name] set Name='Danville Life Saving & First Aid Crew Inc' WHERE Name='Danville Life Saving and First Aid Crew'
UPDATE [EMSmart_Dev_IT].[dbo].[simx_company_name] set Name='Danville Life Saving & First Aid Crew Inc' WHERE Name='Danville Life Saving and First Aid Crew'

SELECT * FROM dbo.simx_company_name WHERE NAME LIKE 'Maryland%'
SELECT * FROM [RCSQL].dbo.Companies WHERE name like 'Johns%'
UPDATE dbo.simx_company_name SET company_id=5593 WHERE id=24
286227          Maryland Height Fire Protection District
*/


SELECT t.id, t.incident_num, t.created_at, s.FileId, s.Trip_Id
FROM trip t FULL OUTER JOIN simx_files s
ON t.id=s.Trip_Id --OR (s.Created BETWEEN '08-29-2018' AND '08-30-2018' AND Trip_Id IS NULL)
WHERE created_at BETWEEN '08-29-2018' AND '08-30-2018'
ORDER BY t.incident_num

