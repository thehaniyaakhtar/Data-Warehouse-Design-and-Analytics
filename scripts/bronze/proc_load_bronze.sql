-- defines stored procedure
DELIMITER //

-- create stored procedure to load data into bronze layer tables
CREATE PROCEDURE load_bronze()
BEGIN
	-- Declare variables to track time for each data load
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    
    -- Decorative Log Lines
    SELECT '=========================================' AS '';
    SELECT 'Loading Bronze Layer' AS '';
    SELECT '=========================================' AS '';
    
    SELECT '>> Loading bronze_crm_cust_info' AS '';
    SET start_time = NOW();
    TRUNCATE TABLE bronze_crm_cust_info;
    
    LOAD DATA LOCAL INFILE 'SQL_DWH\datasets\source_crm\cust_info.csv'
    INTO TABLE bronze.crm_cust_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS '';
	
    SELECT '>> Loading bronze_erp_cust_az12' AS '';
    SET start_time = NOW();
    TRUNCATE TABLE bronze_crm_prd_info;
    
    LOAD DATA LOCAL INFILE 'SQL_DWH\datasets\source_crm\prd_info.csv'
    INTO TABLE bronze.crm_prd_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), 'seconds') AS '';
    
    -- sales details
    
    SELECT '>> Loading bronze_crm_sales_details' AS '';
    SET set_time = NOW();
    TRUNCATE TABLE bronze.crm_sales_details;
    
    LOAD DATA LOCAL INFILE 'SQL_DWH\datasets\source_crm\sales_data.csv'
	INTO TABLE bronze.crm_sales_details
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '/n'
    IGNORE 1 ROWS;
    
    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), 'seconds' AS '');
    
    SELECT '>> Loading bronze_erp_cust_as12' AS '';
    SET start_time = NOW();
    TRUNCATE TABLE bronze.erp_cust_az12;
    
    LOAD DATA LOCAL INFILE 'SQL_DWH\datasets\source_erp\CUST_AZ12.csv'
    INTO TABLE bronze.erp_cust_az12
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
    SET end_time = NOW();
    SELECT CONCAT('Load duration: ', TIMESTAMP DIFF(SECOND, start_time, end_time), 'seconds') AS ''

	SELECT '>> Loading bronze_erp_px_cat_g1v2' AS '';
    START start_time = NOW();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    
    LOAD DATA LOCAL INFILE 'SQL_DWH\datasets\source_erp\PX_CAT_G1V2.csv'
    INTO TABLE bronze.erp_px_cat_g1v2
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
    SET end_time = NOW();
    SELECT CONCAT('Load Duration: ', TIMESTAMPDIFF(SECOND, start_time, end_time), ' seconds') AS '';
	
     SELECT '============================' AS '';  -- Decorative end log
    SELECT 'Bronze Layer Loading Complete' AS '';  -- Indicate procedure completion
    SELECT '============================' AS '';  -- Decorative end log
END//

-- Reset delimiter back to default
DELIMITER ;
	
