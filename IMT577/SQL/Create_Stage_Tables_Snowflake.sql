-- Create Stage Tables in Snowflake
CREATE STAGE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC".Stage_Channel 
URL = 'azure:// imt577sourcedata.blob.core.windows.net/channel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');

-- Create Detail for Stage tables
CREATE TABLE "IMT577_DW_MIKE_WILSON_M5"."PUBLIC"."STAGE_CHANNEL" 
("CHANNELID" INTEGER NOT NULL, "CHANNELCATEGORYID" INTEGER NOT NULL, "CHANNEL" VARCHAR (255) NOT NULL, "CREATEDDATE" DATE NOT NULL);
