USE [master]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitStrings]    Script Date: 1/31/2020 1:16:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitStrings]
(
   @List       NVARCHAR(MAX),
   @Delimiter  NVARCHAR(255)
)
RETURNS TABLE
WITH SCHEMABINDING
AS
   RETURN 
   (  
      SELECT Item = y.i.value('(./text())[1]', 'nvarchar(4000)')
      FROM 
      ( 
        SELECT x = CONVERT(XML, '<i>' 
          + REPLACE(@List, @Delimiter, '</i><i>') 
          + '</i>').query('.')
      ) AS a CROSS APPLY x.nodes('i') AS y(i)
   );
GO

