-- Check data loaded
Select * From Stage_Product;

-- Truncate data
Truncate Table if exists Stage_Product;

-- Clean up stage
Remove @Stage_Product;