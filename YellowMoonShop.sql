USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 10/14/2020 11:02:06 PM ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY FULL 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'YellowMoonShop', N'ON'
GO
ALTER DATABASE [YellowMoonShop] SET QUERY_STORE = OFF
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 10/14/2020 11:02:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Username] [varchar](100) NOT NULL,
	[Password] [varchar](100) NULL,
	[Role] [varchar](100) NULL,
	[Name] [varchar](100) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cake]    Script Date: 10/14/2020 11:02:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cake](
	[CakeID] [int] IDENTITY(1,1) NOT NULL,
	[CakeName] [varchar](100) NULL,
	[Image] [varchar](100) NULL,
	[Description] [varchar](max) NOT NULL,
	[Price] [int] NULL,
	[CreateDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[Quantities] [int] NULL,
	[StatusID] [int] NULL,
	[CategoryID] [int] NULL,
	[LastUpdateUser] [varchar](100) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Cake] PRIMARY KEY CLUSTERED 
(
	[CakeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/14/2020 11:02:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar](100) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/14/2020 11:02:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[CakeID] [int] NULL,
	[Price] [int] NULL,
	[Quantities] [int] NULL,
 CONSTRAINT [PK_Order_Detail] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/14/2020 11:02:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NULL,
	[Fullname] [varchar](100) NULL,
	[Phone] [varchar](100) NULL,
	[ShippingAddress] [varchar](100) NULL,
	[PaymentMethod] [varchar](100) NULL,
	[PaymentStatus] [varchar](100) NULL,
	[Total] [int] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 10/14/2020 11:02:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] NOT NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([Username], [Password], [Role], [Name]) VALUES (N'astius', N'123', N'Member', N'Astius')
INSERT [dbo].[Account] ([Username], [Password], [Role], [Name]) VALUES (N'guest', N'123', N'Member', N'Guest')
INSERT [dbo].[Account] ([Username], [Password], [Role], [Name]) VALUES (N'hauhuong', N'123', N'Admin', N'Hau Huong')
SET IDENTITY_INSERT [dbo].[Cake] ON 

INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (1, N'test9', N'Mooncake.jpg', N'test9', 100000, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-16T00:00:00.000' AS DateTime), 9, 1, 1, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (11, N'Test1', N'Mooncake.jpg', N'test1', 200000, CAST(N'2020-10-10T00:00:00.000' AS DateTime), CAST(N'2020-10-30T00:00:00.000' AS DateTime), 9, 1, 1, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (12, N'Test2', N'Mooncake.jpg', N'test2', 300000, CAST(N'2020-11-06T00:00:00.000' AS DateTime), CAST(N'2020-11-07T00:00:00.000' AS DateTime), 7, 1, 2, N'Hau Huong', CAST(N'2020-10-11T21:29:41.107' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (13, N'Test3', N'Mooncake.jpg', N'test3', 560000, CAST(N'2020-10-06T00:00:00.000' AS DateTime), CAST(N'2020-10-29T00:00:00.000' AS DateTime), 7, 1, 1, N'Hau Huong', CAST(N'2020-10-14T21:11:20.267' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (14, N'Test4', N'Mooncake.jpg', N'test4', 250000, CAST(N'2020-09-28T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 1, 2, 2, N'Hau Huong', CAST(N'2020-10-14T17:23:48.073' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (15, N'Test5', N'Mooncake.jpg', N'test5', 190000, CAST(N'2020-10-06T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 1, 1, 1, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (16, N'Test6', N'Mooncake.jpg', N'test6', 2450000, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-24T00:00:00.000' AS DateTime), 1, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (17, N'Test7', N'Mooncake.jpg', N'test7', 195000, CAST(N'2020-10-07T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 0, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (18, N'test10', N'Mooncake.jpg', N'test8', 1000000, CAST(N'2020-10-07T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 10, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (19, N'Test8', N'Mooncake.jpg', N'test8', 150000, CAST(N'2020-10-07T00:00:00.000' AS DateTime), CAST(N'2020-10-24T00:00:00.000' AS DateTime), 2, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (20, N'Test13', N'Mooncake.jpg', N'test13', 249000, CAST(N'2020-10-14T00:00:00.000' AS DateTime), CAST(N'2020-10-29T00:00:00.000' AS DateTime), 2, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (21, N'Test13', N'Mooncake.jpg', N'test13', 249000, CAST(N'2020-10-14T00:00:00.000' AS DateTime), CAST(N'2020-10-29T00:00:00.000' AS DateTime), 2, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (22, N'Test14', N'Mooncake.jpg', N'test14', 199999, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-16T00:00:00.000' AS DateTime), 2, 1, 1, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (23, N'Test4', N'Mooncake.jpg', N'test4', 250000, CAST(N'2020-09-28T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 0, 1, 2, NULL, NULL)
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (24, N'Test4', N'Mooncake.jpg', N'test4', 250000, CAST(N'2020-10-06T00:00:00.000' AS DateTime), CAST(N'2020-10-31T00:00:00.000' AS DateTime), 1, 1, 2, N'Hau Huong', CAST(N'2020-10-14T21:08:43.520' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (25, N'Testtest', N'Mooncake.jpg', N'testagain', 149000, CAST(N'2020-10-15T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 10, 2, 2, N'Hau Huong', CAST(N'2020-10-14T22:22:58.967' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (26, N'MoonCake', N'Mooncake.jpg', N'meaaa', 250000, CAST(N'2020-10-14T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 2, 1, 1, N'Hau Huong', CAST(N'2020-10-14T22:31:45.270' AS DateTime))
INSERT [dbo].[Cake] ([CakeID], [CakeName], [Image], [Description], [Price], [CreateDate], [ExpirationDate], [Quantities], [StatusID], [CategoryID], [LastUpdateUser], [LastUpdateDate]) VALUES (27, N'MoonCake1', N'Mooncake.jpg', N'papa', 129000, CAST(N'2020-10-16T00:00:00.000' AS DateTime), CAST(N'2020-10-23T00:00:00.000' AS DateTime), 2, 1, 1, N'Hau Huong', CAST(N'2020-10-14T22:31:38.370' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cake] OFF
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'Trung Thu')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Mooncake')
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (2, 1, 15, 1000000, 10)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (3, 2, 12, 300000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (4, 3, 14, 250000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (5, 3, 12, 300000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (6, 3, 13, 560000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (7, 4, 12, 300000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (8, 4, 13, 560000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (9, 4, 14, 250000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (10, 5, 16, 2450000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (11, 6, 1, 100000, 2)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (12, 6, 11, 200000, 2)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (13, 7, 23, 250000, 1)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (14, 8, 13, 560000, 2)
INSERT [dbo].[OrderDetail] ([DetailID], [OrderID], [CakeID], [Price], [Quantities]) VALUES (15, 9, 17, 195000, 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (1, N'astius', N'Astius', N'0123456789', N'TPHCM', N'Cash', N'Paid', 1000000, CAST(N'2020-10-13T22:13:26.190' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (2, N'astius', N'Hau Huong', N'0123456878', N'Hanoi', N'Cash', N'Cash', 300000, CAST(N'2020-10-13T22:13:26.190' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (3, N'astius', N'Hau Huong', N'0123456878', N'Hanoi', N'Cash', N'Paid', 1110000, CAST(N'2020-10-13T22:40:02.853' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (4, N'astius', N'Hau Huong', N'0123456878', N'Hanoi', N'Cash', N'Paid', 1110000, CAST(N'2020-10-13T22:40:08.020' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (5, N'astius', N'Hau Huong', N'0123456878', N'Hanoi', N'Cash', N'Paid', 2450000, CAST(N'2020-10-13T22:47:34.147' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (6, N'astius', N'Hau Huong', N'0123456878', N'Hanoi', N'Cash', N'Paid', 600000, CAST(N'2020-10-13T22:49:55.200' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (7, N'astius', N'Kim Hang', N'0121234567', N'Hanoi', N'Cash', N'Paid', 250000, CAST(N'2020-10-14T19:15:31.920' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (8, N'astius', N'Kim Hang', N'0121234567', N'Hanoi', N'Cash', N'Paid', 1120000, CAST(N'2020-10-14T22:13:40.817' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [Username], [Fullname], [Phone], [ShippingAddress], [PaymentMethod], [PaymentStatus], [Total], [Date]) VALUES (9, N'guest', N'Klark Lam', N'0121234567', N'Hanoi', N'Cash', N'Paid', 195000, CAST(N'2020-10-14T22:14:27.653' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
INSERT [dbo].[Status] ([StatusID], [Status]) VALUES (1, N'Active')
INSERT [dbo].[Status] ([StatusID], [Status]) VALUES (2, N'Unavailable')
ALTER TABLE [dbo].[Cake]  WITH CHECK ADD  CONSTRAINT [FK_Cake_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Cake] CHECK CONSTRAINT [FK_Cake_Category]
GO
ALTER TABLE [dbo].[Cake]  WITH CHECK ADD  CONSTRAINT [FK_Cake_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Cake] CHECK CONSTRAINT [FK_Cake_Status]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_Cake] FOREIGN KEY([CakeID])
REFERENCES [dbo].[Cake] ([CakeID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_Order_Detail_Cake]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Account] FOREIGN KEY([Username])
REFERENCES [dbo].[Account] ([Username])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Account]
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
