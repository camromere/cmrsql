CREATE DATABASE AuditDB;
GO

USE AuditDB;
GO


CREATE TABLE dbo.DDLEvents
(
    EventDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EventType    NVARCHAR(64),
    EventDDL     NVARCHAR(MAX),
    EventXML     XML,
    DatabaseName NVARCHAR(255),
    SchemaName   NVARCHAR(255),
    ObjectName   NVARCHAR(255),
    HostName     VARCHAR(64),
    IPAddress    VARCHAR(48),
    ProgramName  NVARCHAR(255),
    LoginName    NVARCHAR(255)
);

CREATE TRIGGER DDLTrigger_Sample
    ON DATABASE
    FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
        @EventData XML = EVENTDATA();
 
    DECLARE @ip varchar(48) = CONVERT(varchar(48), 
        CONNECTIONPROPERTY('client_net_address'));
 
    INSERT AuditDB.dbo.DDLEvents
    (
        EventType,
        EventDDL,
        EventXML,
        DatabaseName,
        SchemaName,
        ObjectName,
        HostName,
        IPAddress,
        ProgramName,
        LoginName
    )
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'NVARCHAR(100)'), 
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        @EventData,
        DB_NAME(),
        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]',  'NVARCHAR(255)'), 
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
        HOST_NAME(),
        @ip,
        PROGRAM_NAME(),
        SUSER_SNAME();
END
GO