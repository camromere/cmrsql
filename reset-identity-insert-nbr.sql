SELECT * FROM facility
SELECT * FROM facility_map
SELECT * FROM facility_type
--DELETE FROM facility_type

DBCC CHECKIDENT ('[facility_type]', RESEED, 0);
GO