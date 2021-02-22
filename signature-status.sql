USE [RCSQL]
GO

/****** Object:  View [dbo].[vw_SignatureStatus]    Script Date: 3/15/2019 3:54:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vw_SignatureStatus]
AS
SELECT        t.tdate, t.job, dbo.ufn_rn(t.tdate, t.RunNumber) AS RunNumber, CASE WHEN s.tdate IS NULL AND s.job IS NULL THEN 'N' ELSE 'Y' END AS S
FROM            dbo.Trips AS t LEFT OUTER JOIN
                         dbo.Trip_Signatures AS s ON t.tdate = s.tdate AND t.job = s.job
GO


SELECT * FROM vw_SignatureStatus
WHERE tdate='2017-11-04' AND job='2765-A'