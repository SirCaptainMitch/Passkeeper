DROP TABLE IF EXISTS dbo.Passcode 

CREATE TABLE [dbo].[Passcode] (
	[PasscodeId] [int] IDENTITY(1,1) NOT NULL
		CONSTRAINT [PK_Passcode] PRIMARY KEY CLUSTERED ([PasscodeId] ASC),
	[PasscodeName] [varchar](50) NOT NULL,
	[Salt] [varchar](100) NOT NULL,
	[Init] VARCHAR(100) NOT NULL, 
	[EncryptedString] [varchar](100) NULL,
	[Created] [smalldatetime] NOT NULL DEFAULT (GETDATE())
)	 

GO