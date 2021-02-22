ALTER DATABASE [RNB_Sup] SET EMERGENCY;
ALTER DATABASE [RNB_Sup] set multi_user
EXEC sp_detach_db [RNB_Sup]
/* DELETE THE LOG FILE */

EXEC sp_attach_single_file_db @DBName = [RCSQL], @physname = N'D:\Databases\RCSQL.mdf'

CREATE DATABASE RCSQL ON (FILENAME = 'D:\Databases\RCSQL.mdf')
FOR ATTACH_FORCE_REBUILD_LOG