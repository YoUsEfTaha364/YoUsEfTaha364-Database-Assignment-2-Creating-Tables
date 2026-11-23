
USE [BidNile]
GO

-- 1. People.City (7 rows)
SET IDENTITY_INSERT [People].[City] ON
GO
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (1, N'Cairo', N'EG')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (2, N'Giza', N'EG')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (3, N'Alexandria', N'EG')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (4, N'Riyadh', N'SA')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (5, N'Jeddah', N'SA')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (6, N'Dubai', N'AE')
INSERT [People].[City] ([CityId], [Name], [CountryCode]) VALUES (7, N'Abu Dhabi', N'AE')
GO
SET IDENTITY_INSERT [People].[City] OFF
GO

-- 2. People.Member (10 rows -- inviters first)

INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111101', N'Ahmed Hassan Ali', 'ahmed.hassan@example.com', '+201001111111', '29005120123456', '1990-05-12', '2025-01-10 09:15:22.123', 1, NULL, 'en', '2025-01-15 10:00:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111104', N'Layla Ibrahim Mostafa', 'layla.ibrahim@example.com', '+966501111114', 'SA198803154321', '1988-03-15', '2025-01-12 11:20:10.456', 4, NULL, 'en', '2025-01-18 09:30:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111106', N'Nour El-Din Samir', 'nour.samir@example.com', '+971501111116', 'AE199207078765', '1992-07-07', '2025-01-14 14:05:33.789', 6, NULL, 'ar', '2025-01-20 12:00:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111109', N'Huda Salem Ali', 'huda.salem@example.com', '+971501111119', 'AE198511119876', '1985-11-11', '2025-01-16 08:45:00.111', 7, NULL, 'ar', NULL)
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111102', N'Sara Mohamed Ahmed', 'sara.mohamed@example.com', '+201001111112', '29509180123457', '1995-09-18', '2025-02-01 10:11:12.222', 1, '11111111-1111-1111-1111-111111111101', 'ar', '2025-02-05 09:00:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111103', N'Omar Khaled Youssef', 'omar.khaled@example.com', '+201221111113', '29802200123458', '1998-02-20', '2025-02-03 16:40:55.333', 2, '11111111-1111-1111-1111-111111111101', 'ar', NULL)
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111105', N'Karim Adel Hassan', 'karim.adel@example.com', '+201011111115', '29306150123459', '1993-06-15', '2025-02-10 12:30:44.444', 3, '11111111-1111-1111-1111-111111111102', 'ar', '2025-02-12 08:00:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111107', N'Mona Tarek Fathy', 'mona.tarek@example.com', '+966551111117', 'SA199404224567', '1994-04-22', '2025-02-15 09:25:00.555', 5, '11111111-1111-1111-1111-111111111104', 'ar', NULL)
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111108', N'Youssef Hany Mahmoud', 'youssef.hany@example.com', '+201551111118', '29712080123460', '1997-12-08', '2025-03-01 18:10:30.666', 1, '11111111-1111-1111-1111-111111111103', 'en', '2025-03-03 10:00:00.000')
INSERT [People].[Member] ([MemberId], [FullName], [Email], [Mobile], [NationalId], [BirthDate], [RegistrationDate], [CityId], [InvitedBy], [PreferredLanguage], [VerifiedAt]) VALUES ('11111111-1111-1111-1111-111111111110', N'Ziad Omar Nabil', 'ziad.omar@example.com', '+971551111120', 'AE200001019999', '2000-01-01', '2025-03-05 20:15:40.777', 6, '11111111-1111-1111-1111-111111111106', 'en', NULL)
GO

-- 3. People.Wallet (10 rows -- one per member; HeldAmount <= Balance)

INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111101', 25000.00, 4000.00, 'EGP', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111102', 12000.00, 0.00, 'EGP', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111103', 8000.00, 1500.00, 'EGP', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111104', 45000.00, 5000.00, 'SAR', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111105', 5000.00, 0.00, 'EGP', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111106', 30000.00, 2500.00, 'AED', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111107', 15000.00, 0.00, 'SAR', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111108', 20000.00, 3000.00, 'EGP', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111109', 60000.00, 0.00, 'AED', '2025-03-10 12:00:00.000')
INSERT [People].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [LastUpdated]) VALUES ('11111111-1111-1111-1111-111111111110', 9000.00, 1000.00, 'AED', '2025-03-10 12:00:00.000')
GO

-- 4. Operations.Warehouse (5 rows -- ManagerId NULL for now, see step 6)
SET IDENTITY_INSERT [Operations].[Warehouse] ON
GO
INSERT [Operations].[Warehouse] ([WarehouseId], [Name], [Capacity], [CityId], [Latitude], [Longitude], [ManagerId], [ManagerStartDate]) VALUES (1, N'Cairo Central Warehouse', 12000, 1, 30.0444196, 31.2357116, NULL, NULL)
INSERT [Operations].[Warehouse] ([WarehouseId], [Name], [Capacity], [CityId], [Latitude], [Longitude], [ManagerId], [ManagerStartDate]) VALUES (2, N'Riyadh North Warehouse', 8000, 4, 24.7135517, 46.6752957, NULL, NULL)
INSERT [Operations].[Warehouse] ([WarehouseId], [Name], [Capacity], [CityId], [Latitude], [Longitude], [ManagerId], [ManagerStartDate]) VALUES (3, N'Dubai Marina Warehouse', 15000, 6, 25.0805, 55.1403, NULL, NULL)
INSERT [Operations].[Warehouse] ([WarehouseId], [Name], [Capacity], [CityId], [Latitude], [Longitude], [ManagerId], [ManagerStartDate]) VALUES (4, N'Giza West Warehouse', 5000, 2, 30.0131, 31.2089, NULL, NULL)
INSERT [Operations].[Warehouse] ([WarehouseId], [Name], [Capacity], [CityId], [Latitude], [Longitude], [ManagerId], [ManagerStartDate]) VALUES (5, N'Jeddah Port Warehouse', 9500, 5, 21.4858, 39.1925, NULL, NULL)
GO
SET IDENTITY_INSERT [Operations].[Warehouse] OFF
GO

-- 5. Operations.Employee (6 rows)

INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111102', 1)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111104', 1)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111106', 2)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111107', 4)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111109', 3)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES ('11111111-1111-1111-1111-111111111110', 5)
GO

-- 6. Set the warehouse managers (UPDATE, not INSERT -- the circular
--    Warehouse <-> Employee relationship: see the header of this file)
UPDATE [Operations].[Warehouse] SET [ManagerId] = '11111111-1111-1111-1111-111111111104', [ManagerStartDate] = '2025-02-01' WHERE [WarehouseId] = 1
UPDATE [Operations].[Warehouse] SET [ManagerId] = '11111111-1111-1111-1111-111111111106', [ManagerStartDate] = '2025-02-10' WHERE [WarehouseId] = 2
UPDATE [Operations].[Warehouse] SET [ManagerId] = '11111111-1111-1111-1111-111111111109', [ManagerStartDate] = '2025-03-01' WHERE [WarehouseId] = 3
GO

-- 7. Catalog.Category (5 rows -- parents before children)

INSERT [Catalog].[Category] ([CategoryId], [NameEn], [NameAr], [ParentCategoryId], [CommissionRate]) VALUES (100, N'Vehicles', N'مركبات', NULL, 10.00)
INSERT [Catalog].[Category] ([CategoryId], [NameEn], [NameAr], [ParentCategoryId], [CommissionRate]) VALUES (200, N'Electronics', N'إلكترونيات', NULL, 12.00)
INSERT [Catalog].[Category] ([CategoryId], [NameEn], [NameAr], [ParentCategoryId], [CommissionRate]) VALUES (300, N'Antiques', N'تحف', NULL, 20.00)
INSERT [Catalog].[Category] ([CategoryId], [NameEn], [NameAr], [ParentCategoryId], [CommissionRate]) VALUES (110, N'Cars', N'سيارات', 100, 7.50)
INSERT [Catalog].[Category] ([CategoryId], [NameEn], [NameAr], [ParentCategoryId], [CommissionRate]) VALUES (210, N'Mobiles', N'موبايلات', 200, 15.00)
GO

-- 8. Catalog.Item (8 rows)
SET IDENTITY_INSERT [Catalog].[Item] ON
GO
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (1, N'Toyota Corolla 2019 - Excellent Condition', N'Well maintained family car, first owner, full service history.', 8, N'{"brand":"Toyota","model":"Corolla","year":2019,"mileageKm":85000}', '11111111-1111-1111-1111-111111111101', 110, 1, '11111111-1111-1111-1111-111111111104', '2025-03-12 10:00:00.000', 1)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (2, N'iPhone 13 Pro 256GB - Like New', N'Barely used, battery health 96%, with original box and charger.', 9, N'{"storage":"256GB","colour":"Sierra Blue"}', '11111111-1111-1111-1111-111111111103', 210, 2, '11111111-1111-1111-1111-111111111106', '2025-03-13 11:30:00.000', 0)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (3, N'Samsung Galaxy S22 Ultra', N'Good condition, minor scratches on the frame, works perfectly.', 7, N'{"storage":"128GB","colour":"Phantom Black"}', '11111111-1111-1111-1111-111111111105', 210, 3, '11111111-1111-1111-1111-111111111109', '2025-03-14 09:15:00.000', 0)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (4, N'Antique Hand-Carved Wooden Chair', N'19th century chair, hand-carved, restored by a specialist.', 6, N'{"material":"walnut wood","era":"19th century","origin":"Cairo"}', '11111111-1111-1111-1111-111111111107', 300, 4, '11111111-1111-1111-1111-111111111104', '2025-03-15 14:20:00.000', 0)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (5, N'Honda Civic 2020 - Low Mileage', N'Low mileage, accident free, new tyres.', 9, N'{"brand":"Honda","model":"Civic","year":2020,"mileageKm":42000}', '11111111-1111-1111-1111-111111111108', 110, 1, '11111111-1111-1111-1111-111111111106', '2025-03-16 16:45:00.000', 0)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (6, N'MacBook Air M2 2022', N'8GB RAM, 256GB SSD, cycle count 120.', 8, N'{"brand":"Apple","model":"MacBook Air M2","ramGb":8,"storageGb":256}', '11111111-1111-1111-1111-111111111102', 200, 2, '11111111-1111-1111-1111-111111111109', '2025-03-17 12:00:00.000', 1)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (7, N'Vintage Film Camera - Canon AE-1', N'Classic 35mm camera, shutter works, light seals replaced.', 5, N'{"brand":"Canon","model":"AE-1","film":"35mm","year":1981}', '11111111-1111-1111-1111-111111111110', 300, NULL, '11111111-1111-1111-1111-111111111104', '2025-03-18 10:30:00.000', 0)
INSERT [Catalog].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (8, N'Toyota Yaris 2021 - Almost New', N'Almost new, still under warranty, one owner.', 10, N'{"brand":"Toyota","model":"Yaris","year":2021,"mileageKm":18000}', '11111111-1111-1111-1111-111111111101', 110, 1, '11111111-1111-1111-1111-111111111109', '2025-03-19 09:00:00.000', 0)
GO
SET IDENTITY_INSERT [Catalog].[Item] OFF
GO

-- 9. Catalog.ItemPhoto (14 rows)

INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (1, 1, 'https://cdn.bidnile.example/photos/item-1-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (1, 2, 'https://cdn.bidnile.example/photos/item-1-2.jpg', 0)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (1, 3, 'https://cdn.bidnile.example/photos/item-1-3.jpg', 0)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (2, 1, 'https://cdn.bidnile.example/photos/item-2-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (2, 2, 'https://cdn.bidnile.example/photos/item-2-2.jpg', 0)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (3, 1, 'https://cdn.bidnile.example/photos/item-3-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (3, 2, 'https://cdn.bidnile.example/photos/item-3-2.jpg', 0)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (4, 1, 'https://cdn.bidnile.example/photos/item-4-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (5, 1, 'https://cdn.bidnile.example/photos/item-5-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (5, 2, 'https://cdn.bidnile.example/photos/item-5-2.jpg', 0)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (6, 1, 'https://cdn.bidnile.example/photos/item-6-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (7, 1, 'https://cdn.bidnile.example/photos/item-7-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (8, 1, 'https://cdn.bidnile.example/photos/item-8-1.jpg', 1)
INSERT [Catalog].[ItemPhoto] ([ItemId], [PhotoOrder], [PhotoUrl], [IsMain]) VALUES (8, 2, 'https://cdn.bidnile.example/photos/item-8-2.jpg', 0)
GO

-- 10. Sales.Auction (8 rows -- every status; +02:00, +03:00 and +04:00)
SET IDENTITY_INSERT [Sales].[Auction] ON
GO
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (1, 1, 150000.00, 180000.00, 1000.00, '2026-11-20 18:30:00 +02:00', '2026-11-27 18:30:00 +02:00', 'Live', 250000.00)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (2, 1, 140000.00, 170000.00, 1000.00, '2026-11-01 18:00:00 +02:00', '2026-11-08 18:00:00 +02:00', 'Ended', NULL)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (3, 2, 12000.00, NULL, 100.00, '2026-11-21 20:00:00 +03:00', '2026-11-28 20:00:00 +03:00', 'Live', 18000.00)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (4, 3, 9000.00, 11000.00, 100.00, '2026-11-10 19:00:00 +04:00', '2026-11-17 19:00:00 +04:00', 'Ended', NULL)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (5, 4, 2500.00, NULL, 50.00, '2026-11-22 17:00:00 +02:00', '2026-11-29 17:00:00 +02:00', 'Cancelled', NULL)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (6, 5, 180000.00, 200000.00, 1000.00, '2026-12-01 18:00:00 +03:00', '2026-12-08 18:00:00 +03:00', 'Draft', 260000.00)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (7, 6, 20000.00, NULL, 200.00, '2026-12-05 18:30:00 +04:00', '2026-12-12 18:30:00 +04:00', 'PendingReview', NULL)
INSERT [Sales].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartAt], [EndAt], [Status], [BuyNowPrice]) VALUES (8, 8, 160000.00, 190000.00, 1000.00, '2026-11-23 18:30:00 +04:00', '2026-11-30 18:30:00 +04:00', 'Live', 240000.00)
GO
SET IDENTITY_INSERT [Sales].[Auction] OFF
GO

-- 11. Sales.Bid (40 rows -- amounts unique inside each auction)
SET IDENTITY_INSERT [Sales].[Bid] ON
GO
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (1, 1, '11111111-1111-1111-1111-111111111105', 151000.00, '2026-11-21 10:00:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (2, 1, '11111111-1111-1111-1111-111111111107', 152000.00, '2026-11-21 11:07:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (3, 1, '11111111-1111-1111-1111-111111111108', 153000.00, '2026-11-21 12:14:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (4, 1, '11111111-1111-1111-1111-111111111110', 154000.00, '2026-11-21 13:21:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (5, 1, '11111111-1111-1111-1111-111111111101', 155000.00, '2026-11-21 14:28:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (6, 1, '11111111-1111-1111-1111-111111111104', 156000.00, '2026-11-21 15:35:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (7, 1, '11111111-1111-1111-1111-111111111106', 157000.00, '2026-11-21 16:42:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (8, 1, '11111111-1111-1111-1111-111111111109', 158000.00, '2026-11-21 17:49:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (9, 1, '11111111-1111-1111-1111-111111111102', 159000.00, '2026-11-21 10:56:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (10, 1, '11111111-1111-1111-1111-111111111103', 160000.00, '2026-11-21 11:03:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (11, 2, '11111111-1111-1111-1111-111111111107', 141000.00, '2026-11-02 10:00:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (12, 2, '11111111-1111-1111-1111-111111111108', 142000.00, '2026-11-02 11:07:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (13, 2, '11111111-1111-1111-1111-111111111110', 143000.00, '2026-11-02 12:14:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (14, 2, '11111111-1111-1111-1111-111111111101', 144000.00, '2026-11-02 13:21:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (15, 2, '11111111-1111-1111-1111-111111111104', 145000.00, '2026-11-02 14:28:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (16, 2, '11111111-1111-1111-1111-111111111106', 146000.00, '2026-11-02 15:35:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (17, 3, '11111111-1111-1111-1111-111111111101', 12100.00, '2026-11-22 10:00:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (18, 3, '11111111-1111-1111-1111-111111111103', 12200.00, '2026-11-22 11:07:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (19, 3, '11111111-1111-1111-1111-111111111105', 12300.00, '2026-11-22 12:14:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (20, 3, '11111111-1111-1111-1111-111111111107', 12400.00, '2026-11-22 13:21:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (21, 3, '11111111-1111-1111-1111-111111111108', 12500.00, '2026-11-22 14:28:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (22, 3, '11111111-1111-1111-1111-111111111110', 12600.00, '2026-11-22 15:35:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (23, 3, '11111111-1111-1111-1111-111111111101', 12700.00, '2026-11-22 16:42:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (24, 3, '11111111-1111-1111-1111-111111111104', 12800.00, '2026-11-22 17:49:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (25, 4, '11111111-1111-1111-1111-111111111109', 9100.00, '2026-11-11 10:00:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (26, 4, '11111111-1111-1111-1111-111111111102', 9200.00, '2026-11-11 11:07:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (27, 4, '11111111-1111-1111-1111-111111111103', 9300.00, '2026-11-11 12:14:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (28, 4, '11111111-1111-1111-1111-111111111105', 9400.00, '2026-11-11 13:21:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (29, 4, '11111111-1111-1111-1111-111111111107', 9500.00, '2026-11-11 14:28:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (30, 4, '11111111-1111-1111-1111-111111111108', 9600.00, '2026-11-11 15:35:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (31, 8, '11111111-1111-1111-1111-111111111109', 161000.00, '2026-11-24 10:00:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (32, 8, '11111111-1111-1111-1111-111111111102', 162000.00, '2026-11-24 11:07:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (33, 8, '11111111-1111-1111-1111-111111111103', 163000.00, '2026-11-24 12:14:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (34, 8, '11111111-1111-1111-1111-111111111105', 164000.00, '2026-11-24 13:21:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (35, 8, '11111111-1111-1111-1111-111111111107', 165000.00, '2026-11-24 14:28:10.500', '197.45.23.11')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (36, 8, '11111111-1111-1111-1111-111111111108', 166000.00, '2026-11-24 15:35:10.500', '102.188.44.20')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (37, 8, '11111111-1111-1111-1111-111111111110', 167000.00, '2026-11-24 16:42:10.500', '2001:db8:85a3::8a2e:370:7334')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (38, 8, '11111111-1111-1111-1111-111111111101', 168000.00, '2026-11-24 17:49:10.500', '197.45.23.12')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (39, 8, '11111111-1111-1111-1111-111111111104', 169000.00, '2026-11-24 10:56:10.500', '41.234.56.78')
INSERT [Sales].[Bid] ([BidId], [AuctionId], [MemberId], [Amount], [PlacedAt], [DeviceIp]) VALUES (40, 8, '11111111-1111-1111-1111-111111111106', 170000.00, '2026-11-24 11:03:10.500', '197.45.23.11')
GO
SET IDENTITY_INSERT [Sales].[Bid] OFF
GO

-- 12. Marketing.AuctionFollow (12 rows)

INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111101', 3, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111101', 8, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111102', 1, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111102', 3, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111103', 1, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111103', 8, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111105', 3, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111105', 4, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111107', 1, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111108', 3, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111110', 8, '2025-03-20 09:00:00.000')
INSERT [Marketing].[AuctionFollow] ([MemberId], [AuctionId], [FollowedAt]) VALUES ('11111111-1111-1111-1111-111111111110', 1, '2025-03-20 09:00:00.000')
GO
