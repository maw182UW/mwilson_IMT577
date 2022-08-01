-- Update Stage Source tables

-- Product table change
Truncate Table if exists Stage_Product

CREATE or Replace TABLE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."STAGE_PRODUCT" (
    "PRODUCTID" INTEGER NOT NULL
    ,"PRODUCTTYPEID" INTEGER NOT NULL
    ,"PRODUCT" VARCHAR (255) NOT NULL
    ,"COLOR" VARCHAR (255) NOT NULL
    ,"STYLE" VARCHAR (255) NOT NULL
    ,"WEIGHT" FLOAT NOT NULL
    ,"PRICE" FLOAT NOT NULL
    ,"COST" FLOAT NOT NULL
    ,"CREATEDDATE" DATE NOT NULL
    ,"WholeSalePrice" Float Not Null
);

-- Create Customer Stage Table
Truncate Table if exists STAGE_Customer

CREATE or Replace TABLE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."STAGE_CUSTOMER" (
    "CUSTOMERID" VARCHAR (255) NOT NULL
    , "FIRSTNAME" VARCHAR (255) NOT NULL
    , "LASTNAME" VARCHAR (255) NOT NULL
    , "GENDER" VARCHAR (255) NOT NULL
    , "EMAILADDRESS" VARCHAR (255) NOT NULL
    , "ADDRESS" VARCHAR (255) NOT NULL
    , "CITY" VARCHAR (255) NOT NULL
    , "STATEPROVINCE" VARCHAR (255) NOT NULL
    , "COUNTRY" VARCHAR (255) NOT NULL
    , "POSTALCODE" VARCHAR (255) NOT NULL
    , "PHONENUMBER" VARCHAR (255) NOT NULL
    , "CREATEDDATE" DATE NOT NULL
);

-- Create Reseller staging Table
Truncate Table if exists Stage_Reseller

CREATE or Replace TABLE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."STAGE_Reseller" (
    "ResellerID" Varchar(255) NOT NULL
    ,"Contact" VARCHAR (255) NOT NULL
    ,"EmailAddress" VARCHAR (255) NOT NULL
    ,"Adress" VARCHAR (255) NOT NULL
    ,"City" VARCHAR (255) NOT NULL
    ,"StateProvince" VARCHAR (255) NOT NULL
    ,"Country" VARCHAR (255) NOT NULL
    ,"PostalCode" VARCHAR (255) NOT NULL
    ,"PhoneNumber" VARCHAR (255) NOT NULL
    ,"CreatedDate" Date Not Null
    ,"ResellerName" VARCHAR (255) NOT NULL
);

-- Create ChannelCategory staging table
Truncate Table if exists STAGE_ChannelCategory

CREATE or Replace TABLE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."STAGE_ChannelCategory" (
    "ChannelCategoryID" INTEGER NOT NULL
    ,"ChannelCategory" VARCHAR (255) NOT NULL
    ,"CREATEDDATE" DATE NOT NULL
);

-- Create Stage Tables in Snowflake (Example)
CREATE STAGE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC".Stage_Customer 
URL = 'azure:// imt577sourcedata.blob.core.windows.net/channel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');

CREATE STAGE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC".Stage_Reseller 
URL = 'azure:// imt577sourcedata.blob.core.windows.net/channel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');

CREATE STAGE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC".Stage_ChannelCategory 
URL = 'azure:// imt577sourcedata.blob.core.windows.net/channel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');