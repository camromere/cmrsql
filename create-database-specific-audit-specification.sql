USE [msdb]
GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-20191218-102857]
FOR SERVER AUDIT [SQLAgentJobs]
ADD (DELETE ON OBJECT::[dbo].[sysjobs] BY [dbo]),
ADD (INSERT ON OBJECT::[dbo].[sysjobs] BY [dbo]),
ADD (UPDATE ON OBJECT::[dbo].[sysjobs] BY [dbo]),
ADD (EXECUTE ON OBJECT::[dbo].[sp_add_job] BY [dbo]),
ADD (EXECUTE ON OBJECT::[dbo].[sp_update_job] BY [dbo]),
ADD (EXECUTE ON OBJECT::[dbo].[sp_delete_job] BY [dbo])
WITH (STATE = ON)
GO


