USE EMSmart

/*
REPLACE THE STAGE ENVIRONMENT TABLE WITH DATA FROM THE DEV ENVIRONMENT CORRESPONDING TABLE
*/

BEGIN TRAN
	DELETE FROM [EMSmart_Stage].dbo.simx_tcprojects;
	
	SET IDENTITY_INSERT [EMSmart_Stage].dbo.simx_tcprojects ON;

	INSERT INTO [EMSmart_Stage].dbo.simx_tcprojects
	([TCProjectID],[TCName],[TCCreated],[TCUpdated],[TCStatus],[TCNotes],[TCOrder],[FormatID],[Run],[Ret])
	SELECT [TCProjectID],[TCName],[TCCreated],[TCUpdated],[TCStatus],[TCNotes],[TCOrder],[FormatID],[Run],[Ret]
	FROM [EMSmart_Dev].dbo.simx_tcprojects;

	SET IDENTITY_INSERT [EMSmart_Stage].dbo.simx_tcprojects OFF;

/*
COMMIT TRAN
ROLLBACK TRAN
*/