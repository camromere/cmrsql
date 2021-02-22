IF OBJECT_ID('tempdb..#user') IS NOT NULL
    DROP TABLE #user;

SELECT * INTO #user FROM OPENQUERY([ADMINPORTAL-PROD64],'SELECT * FROM ems_admin.user');

DECLARE @company as table 
(
	id int
,	name varchar(255)
,	ids varchar(255)
)
INSERT INTO @company
SELECT id, name, REPLACE(REPLACE(email_recipients,'[',''),']','') AS ids
FROM EMSmart.dbo.Company c
WHERE email_recipients<>'[]'

select DISTINCT c.name, f.item, u.email
from 
	@company as c
cross apply 
	dbo.SplitStrings(c.ids, ',') as f
left join 
	#user as u on
		u.id = cast(f.item as int)
ORDER BY f.item;