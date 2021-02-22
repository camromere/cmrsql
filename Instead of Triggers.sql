/* fun to use when developers leave their pc's unlocked */
 
CREATE TABLE Test (
      TestID            int IDENTITY(1,1) NOT NULL
,     Name        varchar(64)             NULL
,   CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED ([TestID] ASC) 
)
GO
 
INSERT INTO Test (Name)
VALUES ('Hello World')
GO
 
SELECT *
  FROM dbo.Test
GO
 
CREATE TRIGGER tiTest ON Test INSTEAD OF INSERT
AS
BEGIN
      RETURN
END
GO
 
INSERT INTO Test (Name)
VALUES ('Good Bye World')
GO
 
SELECT *
  FROM dbo.Test
GO
