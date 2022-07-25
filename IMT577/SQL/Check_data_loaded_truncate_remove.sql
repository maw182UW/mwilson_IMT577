-- Check data loaded
Select * From Stage_Product;
Select * From Stage_ProductType;
Select * From Stage_ProductCategory;
Select * From Stage_Store;
Select * From Stage_TargetDataChannel;
Select * From Stage_TargetDataProduct;
Select * From Stage_Channel;
Select * From Stage_SalesDetail;
Select * From Stage_SalesHeader;

-- Truncate data
Truncate Table if Exists Stage_Product;
Truncate Table if Exists Stage_ProductType;
Truncate Table if Exists Stage_ProductCategory;
Truncate Table if Exists Stage_Store;
Truncate Table if Exists Stage_TargetDataChannel;
Truncate Table if Exists Stage_TargetDataProduct;
Truncate Table if Exists Stage_Channel;
Truncate Table if Exists Stage_SalesDetail;
Truncate Table if Exists Stage_SalesHeader;

-- Clean up stage
Remove @Stage_Product;
Remove @Stage_ProductType;
Remove @Stage_ProductCategory;
Remove @Stage_Store;
Remove @Stage_TargetDataChannel;
Remove @Stage_TargetDataProduct;
Remove @Stage_Channel;
Remove @Stage_SalesDetail;
Remove @Stage_SalesHeader;