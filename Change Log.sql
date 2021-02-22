GO
/****** Object: Table [DBVersion].[ChangeLog] ******/
SET
ANSI_NULLS ON
GO
SET
QUOTED_IDENTIFIER ON
GO
SET
ANSI_PADDING ON
GO
CREATE
TABLE [dbo].[ChangeLog](
[LogId] [bigint] IDENTITY(1,1) NOT NULL,
[DatabaseName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventType] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ObjectName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ObjectType] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SqlCommand] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventDate] [datetime] NOT NULL DEFAULT (getutcdate()),
[LoginName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY
KEY NONCLUSTERED
(
[LogId] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
GO
SET
ANSI_PADDING OFF
--Trigger
GO
/****** Object: DdlTrigger [ddltrg_ObjectRevisionHistory] ******/
SET
ANSI_NULLS ON
GO
SET
QUOTED_IDENTIFIER ON
GO
CREATE
TRIGGER [ddltrg_ObjectRevisionHistory]
ON
