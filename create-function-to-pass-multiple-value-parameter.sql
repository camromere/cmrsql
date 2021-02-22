CREATE FUNCTION dbo.CSVToList (@CSV varchar(3000)) 
    RETURNS @Result TABLE (Value varchar(30))
AS   
BEGIN
    DECLARE @List TABLE
    (
        Value varchar(30)
    )

    DECLARE
        @Value varchar(30),
        @Pos int

    SET @CSV = LTRIM(RTRIM(@CSV))+ ','
    SET @Pos = CHARINDEX(',', @CSV, 1)

    IF REPLACE(@CSV, ',', '') <> ''
    BEGIN
        WHILE @Pos > 0
        BEGIN
            SET @Value = LTRIM(RTRIM(LEFT(@CSV, @Pos - 1)))

            IF @Value <> ''
                INSERT INTO @List (Value) VALUES (@Value) 

            SET @CSV = RIGHT(@CSV, LEN(@CSV) - @Pos)
            SET @Pos = CHARINDEX(',', @CSV, 1)
        END
    END     

    INSERT @Result
    SELECT
        Value
    FROM
        @List
    
    RETURN
END


/* CALL THE FUNCTION THIS WAY
DECLARE @CSV varchar(100)
SET @CSV = '30,32,34,36,40'

SELECT 
    ProductID, 
    ProductName, 
    UnitPrice
FROM 
    Products
WHERE
    ProductID IN (SELECT * FROM dbo.CSVToLIst(@CSV))
*/