
CREATE DATABASE BidNile;
GO

USE BidNile;
GO

-- schema
CREATE SCHEMA People;
GO

CREATE SCHEMA Operations;
GO

CREATE SCHEMA Catalog;
GO

CREATE SCHEMA Sales;
GO

-- tables

CREATE TABLE People.City (
    CityId      INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_City PRIMARY KEY,
    Name        NVARCHAR(60) NOT NULL,
    CountryCode CHAR(2) NOT NULL
        CONSTRAINT CK_City_CountryCode
            CHECK (CountryCode IN ('EG', 'SA', 'AE')),
    CONSTRAINT UQ_City_Name_CountryCode UNIQUE (Name, CountryCode)
);
GO


CREATE TABLE People.Member (
    MemberId         UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT DF_Member_MemberId DEFAULT NEWID()
        CONSTRAINT PK_Member PRIMARY KEY,
    FullName         NVARCHAR(100) NOT NULL,
    Email            VARCHAR(254) NOT NULL
        CONSTRAINT UQ_Member_Email UNIQUE,
    Mobile           VARCHAR(16) NOT NULL,
    NationalId       VARCHAR(20) NOT NULL
        CONSTRAINT UQ_Member_NationalId UNIQUE,
    BirthDate        DATE NOT NULL
        CONSTRAINT CK_Member_BirthDate
            CHECK (BirthDate <= DATEADD(YEAR, -18, CAST(GETDATE() AS DATE))),
    IsVerified       BIT NOT NULL
        CONSTRAINT DF_Member_IsVerified DEFAULT (0),
    RegistrationDate DATETIME2(3) NOT NULL
        CONSTRAINT DF_Member_RegistrationDate DEFAULT SYSDATETIME(),
    CityId           INT NOT NULL,
    InvitedBy        UNIQUEIDENTIFIER NULL
);
GO


CREATE TABLE People.Wallet (
    MemberId    UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Wallet PRIMARY KEY,
    Balance     DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Wallet_Balance DEFAULT (0.00)
        CONSTRAINT CK_Wallet_Balance CHECK (Balance >= 0),
    HeldAmount  DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Wallet_HeldAmount DEFAULT (0.00)
        CONSTRAINT CK_Wallet_HeldAmount CHECK (HeldAmount >= 0),
    Currency    CHAR(3) NOT NULL
        CONSTRAINT DF_Wallet_Currency DEFAULT ('EGP')
        CONSTRAINT CK_Wallet_Currency CHECK (Currency IN ('EGP', 'SAR', 'AED')),
    LastUpdated DATETIME2(3) NOT NULL
        CONSTRAINT DF_Wallet_LastUpdated DEFAULT SYSDATETIME(),
    -- Table-level CHECK: HeldAmount may never exceed Balance.
    CONSTRAINT CK_Wallet_HeldAmount_Balance CHECK (HeldAmount <= Balance)
);
GO


CREATE TABLE Operations.Warehouse (
    WarehouseId      INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Warehouse PRIMARY KEY,
    Name             NVARCHAR(80) NOT NULL
        CONSTRAINT UQ_Warehouse_Name UNIQUE,
    Capacity         INT NOT NULL
        CONSTRAINT CK_Warehouse_Capacity CHECK (Capacity > 0),
    CityId           INT NOT NULL,
    Latitude         FLOAT NOT NULL
        CONSTRAINT CK_Warehouse_Latitude CHECK (Latitude BETWEEN -90 AND 90),
    Longitude        FLOAT NOT NULL
        CONSTRAINT CK_Warehouse_Longitude CHECK (Longitude BETWEEN -180 AND 180),
    ManagerId        UNIQUEIDENTIFIER NULL
        CONSTRAINT UQ_Warehouse_ManagerId UNIQUE,
    ManagerStartDate DATE NULL,
    -- Table-level CHECK: a start date exists exactly when a manager does.
    CONSTRAINT CK_Warehouse_Manager
        CHECK ((ManagerId IS NULL AND ManagerStartDate IS NULL)
            OR (ManagerId IS NOT NULL AND ManagerStartDate IS NOT NULL))
);
GO


CREATE TABLE Operations.Employee (
    MemberId    UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Employee PRIMARY KEY,
    WarehouseId INT NOT NULL
);
GO


CREATE TABLE Catalog.Category (
    CategoryId       INT NOT NULL
        CONSTRAINT PK_Category PRIMARY KEY,
    NameEn           NVARCHAR(50) NOT NULL
        CONSTRAINT UQ_Category_NameEn UNIQUE,
    NameAr           NVARCHAR(50) NULL,
    ParentCategoryId INT NULL,
    CommissionRate   DECIMAL(5,2) NOT NULL
        CONSTRAINT DF_Category_CommissionRate DEFAULT (0.00)
        CONSTRAINT CK_Category_CommissionRate
            CHECK (CommissionRate BETWEEN 0 AND 30)
);
GO


CREATE TABLE Catalog.Item (
    ItemId         INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Item PRIMARY KEY,
    Title          NVARCHAR(150) NOT NULL,
    Description    NVARCHAR(MAX) NULL,
    ConditionScore TINYINT NOT NULL
        CONSTRAINT CK_Item_ConditionScore
            CHECK (ConditionScore BETWEEN 1 AND 10),
    Specifications NVARCHAR(MAX) NOT NULL
        CONSTRAINT CK_Item_Specifications CHECK (ISJSON(Specifications) = 1),
    SellerId       UNIQUEIDENTIFIER NOT NULL,
    CategoryId     INT NOT NULL,
    WarehouseId    INT NULL,
    InspectorId    UNIQUEIDENTIFIER NULL,
    ListedAt       DATETIME2(3) NOT NULL
        CONSTRAINT DF_Item_ListedAt DEFAULT SYSDATETIME(),
    -- Table-level CHECK: seller and inspector are never the same person.
    CONSTRAINT CK_Item_Seller_Inspector
        CHECK (InspectorId IS NULL OR SellerId <> InspectorId)
);
GO

CREATE TABLE Catalog.ItemPhoto (
    ItemId     INT NOT NULL,
    PhotoOrder TINYINT NOT NULL
        CONSTRAINT CK_ItemPhoto_PhotoOrder CHECK (PhotoOrder BETWEEN 1 AND 20),
    PhotoUrl   VARCHAR(500) NOT NULL,
    IsMain     BIT NOT NULL
        CONSTRAINT DF_ItemPhoto_IsMain DEFAULT (0),
    CONSTRAINT PK_ItemPhoto PRIMARY KEY (ItemId, PhotoOrder)
);
GO


CREATE TABLE Sales.Auction (
    AuctionId     INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Auction PRIMARY KEY,
    ItemId        INT NOT NULL,
    StartingPrice DECIMAL(12,2) NOT NULL
        CONSTRAINT CK_Auction_StartingPrice CHECK (StartingPrice > 0),
    ReservePrice  DECIMAL(12,2) NULL,
    BidIncrement  DECIMAL(12,2) NOT NULL
        CONSTRAINT DF_Auction_BidIncrement DEFAULT (50.00)
        CONSTRAINT CK_Auction_BidIncrement CHECK (BidIncrement > 0),
    StartAt       DATETIMEOFFSET NOT NULL,
    EndAt         DATETIMEOFFSET NOT NULL,
    Status        VARCHAR(20) NOT NULL
        CONSTRAINT DF_Auction_Status DEFAULT ('Draft')
        CONSTRAINT CK_Auction_Status
            CHECK (Status IN ('Draft', 'Live', 'Ended', 'Cancelled')),
    -- Table-level CHECKs: reserve >= starting price; end after start.
    CONSTRAINT CK_Auction_ReservePrice
        CHECK (ReservePrice IS NULL OR ReservePrice >= StartingPrice),
    CONSTRAINT CK_Auction_EndAt CHECK (EndAt > StartAt)
);
GO


CREATE TABLE Sales.Bid (
    BidId      BIGINT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Bid PRIMARY KEY,
    AuctionId  INT NOT NULL,
    MemberId   UNIQUEIDENTIFIER NOT NULL,
    Amount     DECIMAL(12,2) NOT NULL
        CONSTRAINT CK_Bid_Amount CHECK (Amount > 0),
    PlacedAt   DATETIME2(3) NOT NULL
        CONSTRAINT DF_Bid_PlacedAt DEFAULT SYSDATETIME(),
    IpAddress  VARCHAR(45) NOT NULL,
    CONSTRAINT UQ_Bid_Auction_Amount UNIQUE (AuctionId, Amount)
);
GO


CREATE TABLE Sales.AuctionFollow (
    MemberId   UNIQUEIDENTIFIER NOT NULL,
    AuctionId  INT NOT NULL,
    FollowedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_AuctionFollow_FollowedAt DEFAULT SYSDATETIME(),
    CONSTRAINT PK_AuctionFollow PRIMARY KEY (MemberId, AuctionId)
);
GO

--alter queries


ALTER TABLE People.Member
    ADD CONSTRAINT FK_Member_City
        FOREIGN KEY (CityId) REFERENCES People.City (CityId);
GO

-- People.Member -> People.Member, recursive (invited by one member)
ALTER TABLE People.Member
    ADD CONSTRAINT FK_Member_Member
        FOREIGN KEY (InvitedBy) REFERENCES People.Member (MemberId);
GO

-- People.Wallet -> People.Member (1:1; Wallet.MemberId is PK + FK)
ALTER TABLE People.Wallet
    ADD CONSTRAINT FK_Wallet_Member
        FOREIGN KEY (MemberId) REFERENCES People.Member (MemberId);
GO

-- Operations.Employee -> People.Member (an employee is a member)
ALTER TABLE Operations.Employee
    ADD CONSTRAINT FK_Employee_Member
        FOREIGN KEY (MemberId) REFERENCES People.Member (MemberId);
GO

-- Operations.Employee -> Operations.Warehouse (works in one warehouse)
ALTER TABLE Operations.Employee
    ADD CONSTRAINT FK_Employee_Warehouse
        FOREIGN KEY (WarehouseId) REFERENCES Operations.Warehouse (WarehouseId);
GO

-- Operations.Warehouse -> People.City (a warehouse is in one city)
ALTER TABLE Operations.Warehouse
    ADD CONSTRAINT FK_Warehouse_City
        FOREIGN KEY (CityId) REFERENCES People.City (CityId);
GO

-- Operations.Warehouse -> Operations.Employee (managed by one employee)
-- This is the second half of the circular Warehouse <-> Employee
-- relationship; it can only be added now that both tables exist.
ALTER TABLE Operations.Warehouse
    ADD CONSTRAINT FK_Warehouse_Employee
        FOREIGN KEY (ManagerId) REFERENCES Operations.Employee (MemberId);
GO

-- Catalog.Category -> Catalog.Category, recursive (parent category)
ALTER TABLE Catalog.Category
    ADD CONSTRAINT FK_Category_Category
        FOREIGN KEY (ParentCategoryId) REFERENCES Catalog.Category (CategoryId);
GO

-- Catalog.Item -> People.Member (seller)
ALTER TABLE Catalog.Item
    ADD CONSTRAINT FK_Item_Member_Seller
        FOREIGN KEY (SellerId) REFERENCES People.Member (MemberId);
GO

-- Catalog.Item -> Catalog.Category (one category per item)
ALTER TABLE Catalog.Item
    ADD CONSTRAINT FK_Item_Category
        FOREIGN KEY (CategoryId) REFERENCES Catalog.Category (CategoryId);
GO

-- Catalog.Item -> Operations.Warehouse (stored in one warehouse, if arrived)
ALTER TABLE Catalog.Item
    ADD CONSTRAINT FK_Item_Warehouse
        FOREIGN KEY (WarehouseId) REFERENCES Operations.Warehouse (WarehouseId);
GO

-- Catalog.Item -> People.Member (inspector; never the seller -- see
-- the table-level CHECK in CREATE TABLE)
ALTER TABLE Catalog.Item
    ADD CONSTRAINT FK_Item_Member_Inspector
        FOREIGN KEY (InspectorId) REFERENCES People.Member (MemberId);
GO

-- Catalog.ItemPhoto -> Catalog.Item (weak entity).
-- ON DELETE CASCADE: deleting an item deletes its photos.
ALTER TABLE Catalog.ItemPhoto
    ADD CONSTRAINT FK_ItemPhoto_Item
        FOREIGN KEY (ItemId) REFERENCES Catalog.Item (ItemId)
        ON DELETE CASCADE;
GO

-- Sales.Auction -> Catalog.Item (one item per auction)
ALTER TABLE Sales.Auction
    ADD CONSTRAINT FK_Auction_Item
        FOREIGN KEY (ItemId) REFERENCES Catalog.Item (ItemId);
GO

-- Sales.Bid -> Sales.Auction
ALTER TABLE Sales.Bid
    ADD CONSTRAINT FK_Bid_Auction
        FOREIGN KEY (AuctionId) REFERENCES Sales.Auction (AuctionId);
GO

-- Sales.Bid -> People.Member (bidder)
ALTER TABLE Sales.Bid
    ADD CONSTRAINT FK_Bid_Member
        FOREIGN KEY (MemberId) REFERENCES People.Member (MemberId);
GO

-- Sales.AuctionFollow -> People.Member
ALTER TABLE Sales.AuctionFollow
    ADD CONSTRAINT FK_AuctionFollow_Member
        FOREIGN KEY (MemberId) REFERENCES People.Member (MemberId);
GO

-- Sales.AuctionFollow -> Sales.Auction
ALTER TABLE Sales.AuctionFollow
    ADD CONSTRAINT FK_AuctionFollow_Auction
        FOREIGN KEY (AuctionId) REFERENCES Sales.Auction (AuctionId);
GO


ALTER TABLE People.Member
    ADD PreferredLanguage CHAR(2) NOT NULL
        CONSTRAINT DF_Member_PreferredLanguage DEFAULT ('ar')
        CONSTRAINT CK_Member_PreferredLanguage
            CHECK (PreferredLanguage IN ('ar', 'en'));
GO


ALTER TABLE Catalog.Item
    ADD IsFeatured BIT NOT NULL
        CONSTRAINT DF_Item_IsFeatured DEFAULT (0);
GO


EXEC sp_rename N'Sales.Bid.IpAddress', N'DeviceIp', N'COLUMN';
GO

EXEC sp_rename N'Operations.Warehouse.Capacity', N'MaxItems', N'COLUMN';
GO


ALTER TABLE People.Member
    ALTER COLUMN FullName NVARCHAR(150) NOT NULL;
GO


ALTER TABLE Operations.Warehouse
    DROP CONSTRAINT CK_Warehouse_Capacity;
GO

ALTER TABLE Operations.Warehouse
    ALTER COLUMN MaxItems SMALLINT NOT NULL;
GO

ALTER TABLE Operations.Warehouse
    ADD CONSTRAINT CK_Warehouse_MaxItems CHECK (MaxItems > 0);
GO

ALTER TABLE Catalog.Category
    DROP CONSTRAINT CK_Category_CommissionRate;
GO

ALTER TABLE Catalog.Category
    ADD CONSTRAINT CK_Category_CommissionRate
        CHECK (CommissionRate BETWEEN 0 AND 25);
GO

ALTER TABLE Sales.Auction
    DROP CONSTRAINT DF_Auction_Status;
GO

ALTER TABLE Sales.Auction
    DROP CONSTRAINT CK_Auction_Status;
GO

ALTER TABLE Sales.Auction
    ADD CONSTRAINT DF_Auction_Status DEFAULT ('PendingReview') FOR Status;
GO

ALTER TABLE Sales.Auction
    ADD CONSTRAINT CK_Auction_Status
        CHECK (Status IN ('Draft', 'Live', 'Ended', 'Cancelled', 'PendingReview'));
GO


ALTER TABLE Sales.Auction
    ADD BuyNowPrice DECIMAL(12,2) NULL;
GO

ALTER TABLE Sales.Auction
    WITH CHECK ADD CONSTRAINT CK_Auction_BuyNowPrice
        CHECK (BuyNowPrice IS NULL OR BuyNowPrice > StartingPrice);
GO


ALTER TABLE People.Member
    ADD CONSTRAINT UQ_Member_Mobile UNIQUE (Mobile);
GO


ALTER TABLE People.Member
    ADD VerifiedAt DATETIME2(3) NULL;
GO

ALTER TABLE People.Member
    DROP CONSTRAINT DF_Member_IsVerified;
GO

ALTER TABLE People.Member
    DROP COLUMN IsVerified;
GO


-- --------------------------------------------------------------------------
CREATE SCHEMA Marketing;
GO

ALTER SCHEMA Marketing TRANSFER Sales.AuctionFollow;
GO

