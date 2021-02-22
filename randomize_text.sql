USE [Admin]
GO

/****** Object:  UserDefinedFunction [dbo].[fnRandomizedText]    Script Date: 8/1/2019 10:11:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--Randomization Procedure
CREATE FUNCTION [dbo].[fnRandomizedText] (
@OldValue AS VARCHAR(MAX)
)RETURNS VARCHAR(MAX)

BEGIN

  DECLARE @NewValue AS VARCHAR(MAX)
  DECLARE @nCount AS INT
  DECLARE @cCurrent AS CHAR(1)
  DECLARE @cScrambled AS CHAR(1)
  DECLARE @Random AS REAL
 
  SET @NewValue = ''
  SET @nCount = 0
   WHILE (@nCount <= LEN(@OldValue))
  BEGIN
    SELECT @Random = value FROM random
    SET @cCurrent = SUBSTRING(@OldValue, @nCount, 1)
     IF ASCII(@cCurrent) BETWEEN ASCII('a') AND ASCII('z')
       SET @cScrambled = CHAR(ROUND(((ASCII('z') - ASCII('a') - 1) * @Random + ASCII('a')), 0))
    ELSE IF ASCII(@cCurrent) BETWEEN ASCII('A') AND ASCII('Z')
       SET @cScrambled = CHAR(ROUND(((ASCII('Z') - ASCII('A') - 1) * @Random + ASCII('A')), 0))
    ELSE IF ASCII(@cCurrent) BETWEEN ASCII('0') AND ASCII('9')
       SET @cScrambled = CHAR(ROUND(((ASCII('9') - ASCII('0') - 1) * @Random + ASCII('0')), 0))
    ELSE
       SET @cScrambled = @cCurrent

    SET @NewValue = @NewValue + @cScrambled
    SET @nCount = @nCount + 1

  END
   RETURN LTRIM(RTRIM(@NewValue))
END
GO

CREATE VIEW dbo.random(value) AS SELECT RAND();

IF OBJECT_ID('tempdb..#Randomize') IS NOT NULL
    DROP TABLE #Randomize;


CREATE TABLE #Randomize
( name VARCHAR(30),
address varchar(30),
phone CHAR(10),
ssn CHAR(11)
)

INSERT INTO #Randomize (name, address, phone, ssn)
VALUES ('Hicham Nasseh','6548 Main Drive', '3369874562','123654891')

INSERT INTO #Randomize (name, address, phone, ssn)
VALUES ('Cameron Cook','4569 Jackson Blvd', '3362084512','321459875')

INSERT INTO #Randomize (name, address, phone, ssn)
VALUES ('Carla Romere','304 Tamworth Drive', '4793017769','544324598')

SELECT name, [dbo].[fnRandomizedText](name) AS masked_name, address, [dbo].[fnRandomizedText](address) AS masked_address, phone, [dbo].[fnRandomizedText](phone) AS masked_phone, ssn , [dbo].[fnRandomizedText](ssn) AS masked_ssn FROM #Randomize
