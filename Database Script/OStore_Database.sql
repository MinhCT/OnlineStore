CREATE DATABASE [OnlineStoreDB]
GO
USE [OnlineStoreDB]

GO

CREATE TABLE Accounts (
        Username varchar(20) not null,
        Active bit not null,
        Password varchar(20) not null,
        UserRole varchar(20) not null,
        PRIMARY KEY (Username)
    );

GO
 
CREATE TABLE OrderDetails (
    OrderDetailId varchar(50) not null,
    Amount double precision not null,
    Price double precision not null,
    Quanity int not null,
    OrderId int not null,			-- Foreign Key -> [Orders]
    ProductId varchar(20) not null, -- Foriegn Key -> [Products]
    PRIMARY KEY (OrderDetailId)
);

GO
 
CREATE TABLE Orders (
    OrderId int not null IDENTITY(1,1),
    Amount double precision not null,
    CustomerAddress varchar(255) not null,
    CustomerEmail varchar(128) not null,
    CustomerName varchar(255) not null,
    CustomerPhone varchar(128) not null,
    OrderDate datetime not null,
    OrderNum int not null,
	PRIMARY KEY (OrderId)
);

GO

CREATE TABLE Products (
    ProductId varchar(20) not null,
    CreateDate datetime not null,
	QuantityInStock int not null,
    ProductImage image,
    ProductName varchar(255) not null,
    Price double precision not null,
	CategoryId int not null,		-- Foreign Key -> [Categories]
    PRIMARY KEY (ProductId)
);

GO

CREATE TABLE Categories (
	CategoryId int NOT NULL,
	CategoryName varchar(255) NOT NULL,
	PRIMARY KEY (CategoryId)
);
 
GO

CREATE TABLE Rates (
	RateId int NOT NULL IDENTITY(1,1),
	ProductId varchar(20) NOT NULL,	-- Foreign kKey -> [Products]
	Rating int,						-- Fixed values: 1,2,3,4,5 - Can be NULL
	PRIMARY KEY (RateId)
);

--======================================= ADD CONTRAINTS HERE =======================================--
ALTER TABLE Orders
    ADD CONSTRAINT Unique_OrderNum  unique (OrderNum);

GO

ALTER TABLE OrderDetails
    ADD CONSTRAINT fk_OrderDetails_Orders
    FOREIGN KEY (OrderId)
    REFERENCES Orders(OrderId);

GO
 
ALTER TABLE OrderDetails
    ADD CONSTRAINT fk_OrderDetails_Products
    FOREIGN KEY (ProductId)
    REFERENCES Products(ProductId);

GO

ALTER TABLE Products
	ADD CONSTRAINT fk_Products_Categories
	FOREIGN KEY (CategoryId)
	REFERENCES Categories(CategoryId);

GO

ALTER TABLE Rates
	ADD CONSTRAINT fk_Rates_Products
	FOREIGN KEY (ProductId)
	REFERENCES Products(ProductId);