USE [master]
GO
/****** Object:  Database [AutoLog]    Script Date: 9/21/2021 8:55:40 AM ******/
CREATE DATABASE [AutoLog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AutoLog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AutoLog.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AutoLog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AutoLog_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AutoLog] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AutoLog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AutoLog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AutoLog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AutoLog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AutoLog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AutoLog] SET ARITHABORT OFF 
GO
ALTER DATABASE [AutoLog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AutoLog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AutoLog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AutoLog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AutoLog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AutoLog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AutoLog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AutoLog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AutoLog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AutoLog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AutoLog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AutoLog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AutoLog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AutoLog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AutoLog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AutoLog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AutoLog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AutoLog] SET RECOVERY FULL 
GO
ALTER DATABASE [AutoLog] SET  MULTI_USER 
GO
ALTER DATABASE [AutoLog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AutoLog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AutoLog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AutoLog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AutoLog] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AutoLog] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AutoLog', N'ON'
GO
ALTER DATABASE [AutoLog] SET QUERY_STORE = OFF
GO
USE [AutoLog]
GO
/****** Object:  Table [dbo].[CreditRisks]    Script Date: 9/21/2021 8:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditRisks](
	[CustId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 9/21/2021 8:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 9/21/2021 8:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[CarId] [int] IDENTITY(1,1) NOT NULL,
	[Make] [nchar](50) NULL,
	[Color] [nchar](50) NULL,
	[PetName] [nchar](50) NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/21/2021 8:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustId] [int] NOT NULL,
	[CarId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustId])
REFERENCES [dbo].[Customers] ([CustId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Inventory] FOREIGN KEY([CarId])
REFERENCES [dbo].[Inventory] ([CarId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Inventory]
GO
/****** Object:  StoredProcedure [dbo].[GetPetName]    Script Date: 9/21/2021 8:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mikita Luksha
-- Create date: 08.08.2021
-- Description:	Get car name
-- =============================================
CREATE PROCEDURE [dbo].[GetPetName]
	-- Add the parameters for the stored procedure here
	@carID int,
	@petName char(50) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @petName = PetName from Inventory where CarId = @carID
END
GO
USE [master]
GO
ALTER DATABASE [AutoLog] SET  READ_WRITE 
GO