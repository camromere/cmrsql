RESTORE FILELISTONLY FROM 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_00.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_01.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_02.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_03.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_04.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_05.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_06.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_07.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_08.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_09.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_10.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_11.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_12.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_13.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_14.bak'

RESTORE DATABASE moveitdmz FROM 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_00.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_01.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_02.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_03.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_04.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_05.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_06.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_07.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_08.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_09.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_10.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_11.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_12.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_13.bak', 
	 DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\FULL_(local)_moveitdmz_20200118_115344_14.bak'
	 WITH RECOVERY, REPLACE, 
MOVE 'moveitdmz' 
TO 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\moveitdmz.mdf', 
MOVE 'moveitdmz_log' 
TO 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Log\moveitdmz_log.ldf'
