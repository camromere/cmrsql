/* OBJECTS CREATED */
DECLARE @dateAddedToGoBack int = 30
 
SELECT name, modify_date
FROM sys.objects
WHERE type IN ('P', 'V', 'U', 'PK', 'TR') --SQL_STORED_PROCEDURE, VIEW, USER_TABLE, PRIMARY_KEY_CONSTRAINT, SQL_TRIGGER
AND DATEDIFF(D,create_date, GETDATE()) < @dateAddedToGoBack
 
/* OBJECTS UPDATED */
DECLARE @daysUpdatedToGoBack int = 30
 
SELECT name, modify_date
FROM sys.objects
WHERE type IN ('P', 'V', 'U', 'PK', 'TR') --SQL_STORED_PROCEDURE, VIEW, USER_TABLE, PRIMARY_KEY_CONSTRAINT, SQL_TRIGGER
AND DATEDIFF(D,modify_date, GETDATE()) < @daysUpdatedToGoBack
