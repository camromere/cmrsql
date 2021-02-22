USE Master;
GO

SET NOCOUNT ON

-- 1 - Variable declaration
DECLARE @ClientName varchar(60)
DECLARE @DataPath nvarchar(500)
DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT)

-- 2 - Initialize variables
SET @ClientName = 'TestClientcmr';
SET @DataPath = 'b:\Client Relations\' + @ClientName

-- 3 - @DataPath values
INSERT INTO @DirTree(subdirectory, depth)
EXEC master.sys.xp_dirtree 'b:\' ---@DataPath

-- 4 - Create the @DataPath directory
IF NOT EXISTS (SELECT 1 FROM @DirTree WHERE subdirectory = @ClientName)
EXEC master.dbo.xp_create_subdir @DataPath

-- 5 - Remove all records from @DirTree
DELETE FROM @DirTree

SET NOCOUNT OFF

GO
