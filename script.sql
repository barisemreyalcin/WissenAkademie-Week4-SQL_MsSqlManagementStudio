USE [master]
GO
/****** Object:  Database [ContosoDB]    Script Date: 9.10.2024 21:28:00 ******/
CREATE DATABASE [ContosoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ContosoDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ContosoDB.mdf' , SIZE = 65536KB , MAXSIZE = 102400KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'ContosoDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ContosoDB_log.ldf' , SIZE = 32768KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ContosoDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ContosoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ContosoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContosoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContosoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContosoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContosoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContosoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ContosoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContosoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContosoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContosoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContosoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContosoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContosoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContosoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContosoDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ContosoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContosoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContosoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ContosoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ContosoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContosoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContosoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ContosoDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ContosoDB] SET  MULTI_USER 
GO
ALTER DATABASE [ContosoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ContosoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ContosoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ContosoDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ContosoDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ContosoDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ContosoDB', N'ON'
GO
ALTER DATABASE [ContosoDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [ContosoDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ContosoDB]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[Order] [int] NOT NULL,
	[Product] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [int] NOT NULL,
	[Price]  AS ((([UnitPrice]*[Quantity])*((100)-[Discount]))*(0.01)),
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerNumber] [char](5) NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
	[ContactTitle] [varchar](50) NULL,
	[ContactName] [varchar](50) NULL,
	[Website] [varchar](50) NULL,
	[Email] [varchar](100) NOT NULL,
	[Phone] [varchar](50) NULL,
	[RecordDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[State] [bit] NOT NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[ProductDescription] [varchar](500) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Category] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
	[CategoryDescription] [varchar](500) NULL,
	[State] [bit] NOT NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Customer] [int] NOT NULL,
	[Employee] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[State] [bit] NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT dbo.Customers.CustomerId, dbo.Customers.CompanyName, dbo.Employee.EmployeeId, dbo.Employee.FirstName, dbo.Employee.LastName, dbo.[Order].OrderDate, dbo.OrderDetail.Product, dbo.OrderDetail.UnitPrice, 
                  dbo.OrderDetail.Quantity, dbo.OrderDetail.Discount, dbo.OrderDetail.Price, dbo.Product.ProductId, dbo.Product.ProductName, dbo.Category.CategoryId, dbo.Category.CategoryName
FROM     dbo.Customers INNER JOIN
                  dbo.[Order] ON dbo.Customers.CustomerId = dbo.[Order].Customer INNER JOIN
                  dbo.Employee ON dbo.[Order].Employee = dbo.Employee.EmployeeId INNER JOIN
                  dbo.OrderDetail ON dbo.[Order].OrderId = dbo.OrderDetail.[Order] INNER JOIN
                  dbo.Product ON dbo.OrderDetail.Product = dbo.Product.ProductId INNER JOIN
                  dbo.Category ON dbo.Product.Category = dbo.Category.CategoryId
GO
/****** Object:  Table [dbo].[City]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [bit] NOT NULL,
	[Country] [int] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[State] [bit] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRegion]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRegion](
	[CustomerRegion] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[MainAddress] [bit] NOT NULL,
	[Address] [varchar](500) NULL,
	[City] [int] NOT NULL,
	[Country] [int] NOT NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_CustomerRegion] PRIMARY KEY CLUSTERED 
(
	[CustomerRegion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[Department] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
	[State] [bit] NOT NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeDetail]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeDetail](
	[EmployeeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[Employee] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[BirthDate] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Department] [int] NOT NULL,
	[Gender] [int] NOT NULL,
	[DriveLicenceNumber] [varchar](50) NULL,
	[IdentityNumber] [varchar](50) NULL,
 CONSTRAINT [PK_EmployeeDetail] PRIMARY KEY CLUSTERED 
(
	[EmployeeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 9.10.2024 21:28:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderId] [int] IDENTITY(1,1) NOT NULL,
	[Gender] [varchar](50) NOT NULL,
	[Description] [varchar](50) NULL,
	[State] [bit] NOT NULL,
	[RecordDate] [datetime] NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmployeeDetail]    Script Date: 9.10.2024 21:28:00 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EmployeeDetail] ON [dbo].[EmployeeDetail]
(
	[Employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeDetail_1]    Script Date: 9.10.2024 21:28:00 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EmployeeDetail_1] ON [dbo].[EmployeeDetail]
(
	[IdentityNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeDetail_2]    Script Date: 9.10.2024 21:28:00 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EmployeeDetail_2] ON [dbo].[EmployeeDetail]
(
	[DriveLicenceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[City] ADD  CONSTRAINT [DF_City_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF_Country_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[CustomerRegion] ADD  CONSTRAINT [DF_CustomerRegion_MainAddress]  DEFAULT ((1)) FOR [MainAddress]
GO
ALTER TABLE [dbo].[CustomerRegion] ADD  CONSTRAINT [DF_CustomerRegion_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [DF_Department_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [DF_Department_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Gender] ADD  CONSTRAINT [DF_Gender_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Gender] ADD  CONSTRAINT [DF_Gender_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_State]  DEFAULT ((1)) FOR [State]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_RecordDate]  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([Country])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Country]
GO
ALTER TABLE [dbo].[CustomerRegion]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRegion_City] FOREIGN KEY([City])
REFERENCES [dbo].[City] ([CityId])
GO
ALTER TABLE [dbo].[CustomerRegion] CHECK CONSTRAINT [FK_CustomerRegion_City]
GO
ALTER TABLE [dbo].[CustomerRegion]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRegion_Country] FOREIGN KEY([Country])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[CustomerRegion] CHECK CONSTRAINT [FK_CustomerRegion_Country]
GO
ALTER TABLE [dbo].[CustomerRegion]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRegion_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerRegion] CHECK CONSTRAINT [FK_CustomerRegion_Customers]
GO
ALTER TABLE [dbo].[EmployeeDetail]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetail_Department] FOREIGN KEY([Department])
REFERENCES [dbo].[Department] ([DepartmentId])
GO
ALTER TABLE [dbo].[EmployeeDetail] CHECK CONSTRAINT [FK_EmployeeDetail_Department]
GO
ALTER TABLE [dbo].[EmployeeDetail]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetail_Employee] FOREIGN KEY([Employee])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeDetail] CHECK CONSTRAINT [FK_EmployeeDetail_Employee]
GO
ALTER TABLE [dbo].[EmployeeDetail]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDetail_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([GenderId])
GO
ALTER TABLE [dbo].[EmployeeDetail] CHECK CONSTRAINT [FK_EmployeeDetail_Gender]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customers] FOREIGN KEY([Customer])
REFERENCES [dbo].[Customers] ([CustomerId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customers]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Employee] FOREIGN KEY([Employee])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Employee]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([Order])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([Product])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([Category])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_OrderDetail] CHECK  (([Quantity]<=(10)))
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [CK_OrderDetail]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[36] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customers"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employee"
            Begin Extent = 
               Top = 7
               Left = 308
               Bottom = 170
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Order"
            Begin Extent = 
               Top = 7
               Left = 550
               Bottom = 170
               Right = 744
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "OrderDetail"
            Begin Extent = 
               Top = 7
               Left = 792
               Bottom = 170
               Right = 986
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 7
               Left = 1034
               Bottom = 170
               Right = 1256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Category"
            Begin Extent = 
               Top = 2
               Left = 1289
               Bottom = 165
               Right = 1520
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
USE [master]
GO
ALTER DATABASE [ContosoDB] SET  READ_WRITE 
GO
