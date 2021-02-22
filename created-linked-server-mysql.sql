USE [master]
GO

/****** Object:  LinkedServer [EMSIGHT-PROD]    Script Date: 12/7/2018 5:15:55 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'EMSIGHT-PROD', @srvproduct=N'MySQL', @provider=N'MSDASQL', @datasrc=N'EMSIGHT-PROD'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EMSIGHT-PROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'emsbillingdb',@rmtpassword='iTRIEVirmart14'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EMSIGHT-PROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


