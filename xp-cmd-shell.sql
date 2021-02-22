Exec xp_cmdshell '"\\emsdatamasker\C$\Program Files\Red Gate\Data Masker for SQL Server 6\DataMaskerCmdLine.exe" 
PARFILE=C:\DataMaskerProjects\EDW_Demo\emssql7-rcsql-parfile.txt'

Exec xp_cmdshell 'type C:\DataMaskerProjects\EDW_Demo\emssql7-rcsql-parfile.txt' 

Exec xp_cmdshell 'type "C:\Program Files\Red Gate\Data Masker for SQL Server 6\SampleDatabase\SampleDatabaseReadme.txt"' 