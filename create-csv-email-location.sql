SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================================
-- Author:		Carla Romere
-- Create date: 2020-01-13
-- Description:	Script to email Chris Samia a list of current and active EMSight users' email addresses.
-- ==========================================================================================================
ALTER PROCEDURE usp_Email_EMSight_Users_Email
AS
BEGIN
SET NOCOUNT ON;

DECLARE @Body      NVARCHAR(MAX),
		@TableHead VARCHAR(1000),
        @TableTail VARCHAR(1000)

SET @TableTail = '</table></body></html>';

SET @TableHead
        = '<html><head>' + '<style>'
          + 'td {border: #fffffff; border-width: 0; padding-left:1px; padding-right:1px; padding-top:1px; padding-bottom:1px; font: 14px arial} '
          + '</style>' + '</head>' + '<body>' + '<table cellpadding=0 cellspacing=0 border=0>'
          + '<tr style="background-color:#a42004; color:#ffffff"><td style="text-align:center"><b> -- Current EMSight Users Email Addresses -- </b></td>';

SET @Body = (   SELECT 'The report has been run for the current EMSight users'' email addresses. The report is located here: \\emsfs3\public\Reporting\EMSightUsersReport\EMSightUsers_' + CAST(YEAR(GETDATE()) AS CHAR(4))+CAST(left(datename(month,getdate()),3) AS CHAR(3)) + '.csv.'
					FOR XML RAW('tr'), ELEMENTS);

SELECT @Body = @TableHead + ISNULL(@Body, '') + @TableTail;

SELECT * INTO tempdb..useremail FROM OPENQUERY([ADMINPORTAL-PROD64],
		'SELECT uc.company_id, c.name, u.username, u.first_name, u.last_name, u.status, u.is_password_disabled, ai.description as ''Role''
		FROM user u 
		LEFT JOIN auth_assignment aa ON aa.user_id = u.id
		LEFT JOIN auth_item ai ON ai.name = aa.item_name
		LEFT JOIN user_company uc ON u.id=uc.user_id
		RIGHT JOIN company c on uc.company_id=c.id
		WHERE ai.type = 1 AND u.is_deleted = 0
		AND ai.name LIKE ''client__%'' and ai.name NOT LIKE ''client_demo%''
		AND u.status=''ACTIVE''
		AND u.username NOT LIKE ''%emsbilling.com''
		AND u.username NOT LIKE ''%agshealth.com''
		AND ai.description <> ''Administrator''
		AND u.username NOT IN(''natalie'',''Chris.Samia-Client'',''camromere@gmail.com'');');

BEGIN
DECLARE @ary VARCHAR(800);
DECLARE @date AS CHAR(7) = CAST(YEAR(GETDATE()) AS CHAR(4))+CAST(left(datename(month,getdate()),3) AS CHAR(3));
SET @ary
= 'bcp tempdb..useremail OUT \\emsfs3\public\Reporting\EMSightUsersReport\EMSightUsers_'
+ CAST(YEAR(GETDATE()) AS CHAR(4))+CAST(left(datename(month,getdate()),3) AS CHAR(3)) + '.csv -emssql3 -T -t, -c';
PRINT @ary;
EXEC master.dbo.xp_cmdshell @ary;

EXEC msdb.dbo.sp_send_dbmail @profile_name = 'AdminAccount',
@recipients='Chris.Samia@emsbilling.com',
@subject = 'EMSight Users'' Email Addresses',
@body = @Body,
@body_format = 'HTML';

END

DROP TABLE tempdb..useremail;

END