-- Creates a database master key on tstsql3
-- The key is encrypted using the password "le*sh7zw$VP&rm*6K*NmYJB@@2yaEtwFZ$Ul"  
USE master;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'le*sh7zw$VP&rm*6K*NmYJB@@2yaEtwFZ$Ul';  
GO  

-- Creates the Encryption Certificate on tstsql3
CREATE CERTIFICATE  RCSQLZollDBBackupEncryptCert
   WITH SUBJECT = 'RCSQL-Zoll Backup Encryption Certificate';  
GO  

BACKUP CERTIFICATE RCSQLZollDBBackupEncryptCert
TO FILE = 'D:\BackupCerts\RCSQLZollDBBackupEncryptCert.cer'
WITH PRIVATE KEY
(
    FILE = 'D:\BackupCerts\RCSQLZollDBBackupEncrypt_CERTIFICATE_PRIVATE_KEY.key'
   ,ENCRYPTION BY PASSWORD = 'zollDecrypt2020!'
);

--Create Master Key on my laptop
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'wZY5@4^#VB$hhT9E*mBj0KiF%#7U1QJteSfd';  
GO  

--Move certificate to my laptop
CREATE CERTIFICATE RCSQLZollDBBackupEncryptCert
    FROM FILE = 'C:\dbBackupKeys\RCSQLZollDBBackupEncryptCert.cer'
     WITH PRIVATE KEY 
      ( 
        FILE = 'C:\dbBackupKeys\RCSQLZollDBBackupEncrypt_CERTIFICATE_PRIVATE_KEY.key' ,
        DECRYPTION BY PASSWORD = 'zollDecrypt2020!'
      ) 

--Change connection back to tstsql3
BACKUP DATABASE [RCSQL_Views]  
TO DISK = N'\\emsawssgw1.emsmc.local\sgw1-sqlbackup\tstsql3\full\rcsql_views.bak'  
WITH  
  COMPRESSION,  
  ENCRYPTION   
   (  
   ALGORITHM = AES_256,  
   SERVER CERTIFICATE = RCSQLZollDBBackupEncryptCert  
   ),  
  STATS = 10  
GO

--Change connection my laptop
Alter Database [RCSQL_Views]
SET SINGLE_USER WITH
ROLLBACK IMMEDIATE

--Next run it separately

USE MASTER
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'wZY5@4^#VB$hhT9E*mBj0KiF%#7U1QJteSfd';

--Next command run separately

RESTORE DATABASE [RCSQL_Views] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\rcsql_views.bak' WITH  FILE = 1,  MOVE N'RCSQL_Views' TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\RCSQL_Views.mdf',  MOVE N'Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\RCSQL_Views.ldf',  NOUNLOAD,  REPLACE,  STATS = 5

GO


/*

--1.Create the certificates :

CREATE CERTIFICATE [CertficateName] 
FROM FILE = 'C:\FolderName\NameOfCert.cer'
WITH PRIVATE KEY ( 
    FILE = 'C:\FolderName\NameOfCertKey.key' ,   
    DECRYPTION BY PASSWORD = 'YourPassword'
);

---2.

USE Master ;
Open Master Key Decryption by password = 'YourPassword'
Backup master key to file = 'C:\SQL FodlerName\MasterKeyName.key'
        ENCRYPTION BY PASSWORD = 'YourPassword';
    GO

--3.Restore Master Key

Use master 
    restore master key
    FROM FILE = 'C:\FolderName\MasterKeyName.key'
    DECRYPTION BY PASSWORD = 'YourPassword'
    ENCRYPTION BY PASSWORD = 'YourPassword'

--4. This is the last step you ,be careful at this stage as it took me a while to get that each command needs to be run separately :

Alter Database [DatabaseName]
SET SINGLE_USER WITH
ROLLBACK IMMEDIATE

--Next run it separately

USE MASTER
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'YourPassword';

--Next command run separately

RESTORE DATABASE [RCSQL_Views] FROM DISK = 'C:\Folder\FULL\NameoftheBakFilethat ourAreRestoring.BAK' 
WITH Replace , STATS = 5 

*/