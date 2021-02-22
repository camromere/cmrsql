DECLARE @fCount INT;
SET @fCount = (SELECT COUNT(*) FROM demo.Facilities WHERE name LIKE 'RPS-%' OR name LIKE 'z%RPS-%');
DECLARE @count INT;
SET @count = 1; 

WHILE @count <= @fCount
BEGIN
	UPDATE demo.Facilities
	SET name = CASE WHEN name LIKE 'RPS-%' THEN 'Facility ' 
				WHEN name LIKE 'z%RPS-%' THEN 'zzzFacility ' END
	+ CAST(@count AS VARCHAR(3))
	WHERE (name LIKE 'RPS-%' OR name LIKE 'z%RPS-%') AND code=(SELECT MIN(code) FROM demo.Facilities WHERE name LIKE 'RPS-%' OR name LIKE 'z%RPS-%')
	SET @count = @count + 1
END;
