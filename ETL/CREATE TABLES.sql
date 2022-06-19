-------------------------------------------//---------------------------------

-- CREATION OF TABLES FOR DW

USE [Contoso Direct Sales];

GO

CREATE TABLE DimChannel (
ChannelKey			int				not null,
ChannelLabel		nvarchar (100)		null,
ChannelName			nvarchar(20)		null,
ChannelDescription	nvarchar(50)		null,
UpdateDate			date			null,
CONSTRAINT PK_ChannelKey_ PRIMARY KEY CLUSTERED (ChannelKey ASC)
);

go


CREATE TABLE DimProductCategory (
ProductCategoryKey					int					NOT NULL,	
ProductCategoryLabel				nvarchar(100)		 null,
ProductCategoryName					nvarchar(50)		 null,
ProductCategoryDescription			nvarchar(50)		 null,
UpdateDate							date			 null,
CONSTRAINT PK_ProductCategoryKey PRIMARY KEY CLUSTERED (ProductCategoryKey ASC)
);

CREATE TABLE DimProductSubCategory (
ProductSubcategoryKey	int	NOT NULL,
ProductSubcategoryLabel	nvarchar(100) NULL,
ProductSubcategoryName	nvarchaR(255) NULL,
ProductSubcategoryDesciption	nvarchar(255) NULL,
ProductCategoryKey	int	NULL,
UpdateDate	date	NULL,
CONSTRAINT  PK_ProductSubcategoryKey primary key clustered (ProductSubcategoryKey asc),
constraint FK_ProductCategoryKey FOREIGN KEY (ProductCategoryKey)
references DimProductCategory (ProductCategoryKey)
);

CREATE TABLE DimProduct(
ProductKey						int				not null,
ProductLabel					nvarchar(255)	null,
ProductName						nvarchar(500)   null,
ProductDescription				nvarchar(400)   null,
ProductSubcategoryKey			int				null,
Manufacturer					nvarchar(50)	null,
BrandName						nvarchar(50)	null,
ClassID							nvarchar(50)	null,
ClassName						nvarchar(50)	null,
StyleID							nvarchar(50)	null,
StyleName						nvarchar(50)	null,
ColorID							nvarchar(50)	null,
ColorName						nvarchar(50)	null,
Size							nvarchar(250)	null,
SizeRange						nvarchar(50)	null,
SizeUnitMeasureID				nvarchar(50)	null,
[Weight]						float			null,
WeightUnitMeasureID				nvarchar(50)	null,
UnitOfMeasureID					nvarchar(50)	null,
UnitOfMeasureName				nvarchar(50)	null,
StockTypeID						nvarchar(50)	null,
StockTypeName					nvarchar(50)	null,
UnitCost						float			null,	
UnitPrice						float			null,	
AvailableForSaleDate			date		null,
StopSaleDate					date		null,	
[Status]						nvarchar(50)		null,
UpdateDate						date		null
CONSTRAINT PK_ProductKey PRIMARY KEY CLUSTERED (ProductKey ASC),
CONSTRAINT FK_ProductSubcategoryKey FOREIGN KEY (ProductSubcategoryKey)
    REFERENCES DimProductSubcategory (ProductSubcategoryKey)
);


go


create table DimGeography (
GeographyKey	int	not null,
GeographyType	nvarchar(255) null,
ContinentName	nvarchar(255) null,
CityName	nvarchar(255) null,
StateProvinceName	nvarchar(255) null,
RegionCountryName	nvarchar(255) null,
[geometry_]	nvarchar(500)	null,
UpdateDate	date	null,
constraint PK_GeographyKey PRIMARY KEY CLUSTERED (GeographyKey ASC)
)





CREATE TABLE DimStore (
StoreKey	int	 not null,
GeographyKey	int	null,
StoreManager	int	null,
StoreType	nvarchar(100) null,
StoreName	nvarchar(250) null,
StoreDescription	nvarchar(300) null,
Status_	nvarchar(20) null,
OpenDate	date	 null,
CloseDate	date null,
EntityKey	int	null,
ZipCode	nvarchar(50) null,
ZipCodeExtension	nvarchar(50) null,
StorePhone	nvarchar(50) null,
StoreFax	nvarchar(50) null,
AddressLine1	nvarchar(250) null,
AddressLine2	nvarchar(250) null,
CloseReason	nvarchar(100) null,
EmployeeCount	int	 null,
SellingAreaSize	float	null,
LastRemodelDate	date	null,
GeoLocation	nvarchar(255)	null,
Geometry_	nvarchar(255)	null,
UpdateDate	date	null,
constraint PK_StoreKey Primary key clustered (StoreKey ASC),
constraint FK_GeograpyKey Foreign Key (GeographyKey)
References DimGeography (GeographyKey)
)

create table FactSales (
SalesKey	int	 not null,
DateKey	date  null,	
ChannelKey	int	null,
StoreKey	int	 null,
ProductKey	int	 null,
UnitCost	float	null,
UnitPrice	float	null,
SalesQuantity	int	null,
ReturnQuantity	int	null,
ReturnAmount	float	null,
DiscountQuantity	int	null,
DiscountAmount	float null,
TotalCost	float	null,
SalesAmount	float	null,
UpdateDate	date	null,
constraint PK_SalesKey primary key clustered (SalesKey ASC),
constraint FK_DateKey Foreign Key (DateKey)
references DimDate (DateKey),
constraint FK_ChannelKey foreign key (ChannelKey)
references DimChannel (ChannelKey),
constraint FK_StoreKey foreign key (StoreKey)
references DimStore (StoreKey),
constraint FK_ProductKey foreign key (ProductKey)
references DimProduct (ProductKey)
)
