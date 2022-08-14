/*************************************
Create Fact tables for course project
Create Fact Tables
Check that foreign keys are included
Load data into Fact Tables
*************************************/

-- Create Fact Tables: 

-- ProductSalesTarget

Drop Table Fact_ProductSalesTarget

Create Or Replace Table "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."FACT_PRODUCTSALESTARGET"
(
    DimProductID Int Constraint FK_DimProductID Foreign Key References Dim_Product (DimProductID) -- Foreign Key
    ,DimTargetDateID NUMBER(9) Constraint FK_DimTargetDateID Foreign Key References Dim_Date (Date_PKEY) -- Foreign Key
    ,ProductTargetSalesQuantity Integer
);

SELECT * FROM FACT_PRODUCTSALESTARGET

-- SalesActual

Drop Table Fact_SalesActual

Create Or Replace Table "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."FACT_SALESACTUAL"
(
    DimProductID Int Constraint FK_DimProductID Foreign Key References Dim_Product (DimProductID)
    ,DimStoreID Int Constraint FK_DimStoreID Foreign Key References Dim_Store (DimStoreID)
    ,DimResellerID Int Constraint FK_DimResellerID Foreign Key References Dim_Reseller (DimResellerID)
    ,DimCustomerID Int Constraint FK_DimCustomerID Foreign Key References Dim_Customer (DimCustomerID)
    ,DimChannelID Int Constraint FK_DimChannelID Foreign Key References Dim_Channel (DimChannelID)
    ,DimLocationID Varchar(255) Constraint FK_DimLocationID Foreign Key References Dim_Location (DimLocationID)
    ,DimSalesDateID NUMBER(9) Constraint FK_DimTargetDateID Foreign Key References Dim_Date (Date_PKEY)
    ,SalesHeaderID Integer
    ,SalesDetailID Integer
    ,SalesAmount Float
    ,SalesQuantity Integer
    ,SaleUnitPrice Float
    ,SaleExtendedCost Float
    ,SaleTotalProfit Float
);


-- SRCSalesTarget

Drop Table Fact_SRCSalesTarget

Create Or Replace Table "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."Fact_SRCSALESTARGET"
(
    DimStoreID Int Constraint FK_DimStoreID Foreign Key References Dim_Store (DimStoreID)
    ,DimResellerID Int Constraint FK_DimResellerID Foreign Key References Dim_Reseller (DimResellerID)
    ,DimCustomerID Int Constraint FK_DimCaracterID Foreign Key References Dim_Customer (DimCustomerID)
    ,DimChannelID Int Constraint FK_DimChannelID Foreign Key References Dim_Channel (DimChannelID)
    ,DimTargetDateID NUMBER(9) Constraint FK_DimTargetDateID Foreign Key References Dim_Date (Date_PKEY)
    ,SalesTargetAmount Float
);

Select * From Fact_SRCSalesTarget

-- LOAD DATA INTO FACT TABLES:

-- LOAD UNKNOWN MEMBER FACT_PRODUCTSALESTARGET

INSERT INTO FACT_PRODUCTSALESTARGET
(
    DimProductID
    ,DimTargetDateID
    ,ProductTargetSalesQuantity
)
VALUES
(
    -1
    ,-1
    ,-1
);

-- LOAD UNKNOWN MEMBER FCT_SALESACTUAL

INSERT INTO FACT_SALESACTUAL
(
    DimProductID
    ,DimStoreID
    ,DimResellerID
    ,DimCustomerID
    ,DimChannelID
    ,DimLocationID
    ,DimSalesDateID
    ,SalesHeaderID
    ,SalesDetailID
    ,SalesAmount
    ,SalesQuantity
    ,SaleUnitPrice
    ,SaleExtendedCost
    ,SaleTotalProfit
)
VALUES
(
    -1
    ,-1
    ,-1
    ,-1
    ,-1
    ,"UNKNOWN"
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
);

-- LOAD UNKNOWN MEMBER IN FACT_SRCSALESTARGET

INSERT INTO FACT_SRCSALESTARGET
(
    DimStoreID
    ,DimResellerID
    ,DimCustomerID
    ,DimChannelID 
    ,DimTargetDateID
    ,SalesTargetAmount   
)
VALUES
(
    -1
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
);

-- LOAD FACT_PRODUCTSALESTARGET

INSERT INTO FACT_PRODUCTSALESTARGET
(
    DimProductID
    ,DimTargetDateID
    ,ProductTargetSalesQuantity
)
SELECT DISTINCT
    Dim_Product.DimProductID
    ,Dim_Date.Year AS DimTargetDateID
    ,Stage_TargetDataProduct.SalesQuantityTarget
From Stage_TargetDataProduct
Inner Join Dim_Product on
Dim_Product.ProductID = Stage_TargetDataProduct.ProductID
Inner Join Dim_Date on
Dim_Date.Year = Stage_TargetDataProduct.Year
;


-- LOAD FACT_SRCSALESTARGET

INSERT INTO FACT_SRCSALESTARGET
(
    DimStoreID
    ,DimResellerID
    ,DimCustomerID
    ,DimChannelID 
    ,DimTargetDateID
    ,SalesTargetAmount
)
Select DISTINCT
    Dim_Store.DimStoreID
    ,Dim_Reseller.DimResellerID
    ,Dim_Customer.DimCustomerID
    ,Dim_Channel.DimChannelID
    ,Dim_Date.Year As DimTargetDateID
    ,Stage_TargetDataChannel.TargetSalesAmount As SalesTargetAmount
From Stage_TargetDataChannel
Left Outer Join Dim_Store on
(select (Case When Dim_Store.StoreNumber = '5' then 'Store Number 5'
                    When Dim_Store.StoreNumber = '8' then 'Store Number 8'
                    When Dim_Store.StoreNumber = '10' then 'Store Number 10'
                    When Dim_Store.StoreNumber = '21' then 'Store Number 21'
                    When Dim_Store.StoreNumber = '34' then 'Store Number 34'
                    When Dim_Store.StoreNumber = '39' then 'Store Number 39'
                    Else 'Unknown'
                    End)) = Stage_TargetDataChannel.TargetName
Left Outer Join Dim_Reseller on
Dim_Reseller.ResellerName = Stage_TargetDataChannel.TargetName
Left Outer Join Dim_Customer on
(select (Case When Dim_Customer.CustomerID = '9cfbece1-de7a-4ef5-a766-43f28e7edfa2' And Dim_Customer.CustomerID = '5bd2fd76-c656-4a12-80b1-7a423e380fca' And Dim_Customer.CustomerID = '7ab04e33-c078-462b-a40d-b93e2bc0466b' then 'Customer Sales'
                        Else 'Unknown'
                        End)) = Stage_TargetDataChannel.TargetName
Inner Join Dim_Channel on
Dim_Channel.ChannelName = Stage_TargetDataChannel.ChannelName
Inner Join Dim_Date on
Dim_Date.Year = Stage_TargetDataChannel.Year
;

-- Load Fact_SalesActual
Truncate Table if exists Fact_SalesActual

Insert into Fact_SalesActual
(
    DimProductID
    ,DimStoreID
    ,DimResellerID
    ,DimCustomerID
    ,DimChannelID
    ,DimSalesDateID
    ,DimLocationID
    ,SalesHeaderID
    ,SalesDetailID
    ,SalesAmount
    ,SalesQuantity
    ,SaleUnitPrice
    ,SaleExtendedCost
    ,SaleTotalProfit
)
Select Distinct
    Dim_Product.DimProductID
    ,Dim_Store.DimStoreID
    ,Dim_Reseller.DimResellerID 
    ,Dim_Customer.DimCustomerID
    ,Dim_Channel.DimChannelID
    ,Dim_Date.Date_PKey As DimSalesDateID
    ,Dim_Location.DimLocationID
    ,Stage_SalesDetail.SalesHeaderID As SalesHeaderID
    ,Stage_SalesDetail.SalesDetailID As SalesDetailID
    ,Stage_SalesDetail.SalesAmount As SalesAmount
    ,Stage_SalesDetail.SalesQuantity As SalesQuantity
    ,(Select Stage_SalesDetail.SalesAmount / Stage_SalesDetail.SalesQuantity) As SaleUnitPrice
    ,Dim_Product.ProductCost As SaleExtendedCost
    ,(Select (Stage_SalesDetail.SalesAmount / Stage_SalesDetail.SalesQuantity) - Dim_Product.ProductCost / (Stage_SalesDetail.SalesAmount / Stage_SalesDetail.SalesQuantity)) As SaleTotalProfit
From Stage_SalesDetail
Inner Join Stage_SalesHeader On Stage_SalesHeader.SalesHeaderID = Stage_SalesDetail.SalesHeaderID
Left Outer Join Dim_Store On Dim_Store.SourceStoreID = Stage_SalesHeader.StoreID
Left Outer Join Dim_Reseller on Dim_Reseller.ResellerID = Stage_SalesHeader.ResellerID
Left Outer Join Dim_Customer on Dim_Customer.CustomerID = Stage_SalesHeader.CustomerID
Inner Join Dim_Channel on Dim_Channel.ChannelID = Stage_SalesHeader.ChannelID
Inner Join Dim_Product On Dim_Product.ProductID = Stage_SalesDetail.ProductID
Inner Join Dim_Date On Dim_Date.Date = Stage_SalesHeader.Date
Inner Join Dim_Location On Dim_Location.StoreSourceID = Stage_SalesHeader.StoreID Or Dim_Location.ResellerSourceID = Stage_SalesHeader.ResellerID Or Dim_Location.CustomerSourceID = Stage_SalesHeader.CustomerID
;

Select * From Fact_SalesActual
