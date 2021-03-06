USE [Survey_Sample_A18]
GO
/****** Object:  Trigger [dbo].[trg_refreshSurveyView]    Script Date: 2/8/2020 4:30:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER TRIGGER [dbo].[trg_refreshSurveyView] 
   ON  [dbo].[SurveyStructure] 
   AFTER  INSERT,DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strSQLSurveyData nvarchar(max);
    -- Insert statements for trigger here
	SET @strSQLSurveyData = ' CREATE OR ALTER VIEW vw_AllSurveyData AS ';
	SET @strSQLSurveyData = @strSQLSurveyData
	 + ( SELECT [dbo].[fn_GetAllSurveyDataSQL] () );

	 exec sp_executesql @strSQLSurveyData;
END
