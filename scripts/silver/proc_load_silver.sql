*/
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

DROP PROCEDURE IF EXISTS silver_load_silver;
DELIMITER //

CREATE PROCEDURE silver_load_silver()
BEGIN
    DECLARE start_time DATETIME;
    DECLARE end_time DATETIME;
    DECLARE batch_start_time DATETIME;
    DECLARE batch_end_time DATETIME;

    SET batch_start_time = NOW();

    -- silver.crm_prd_info
    SET start_time = NOW();
    SELECT ">> Truncating Table: silver.crm_prd_info" AS '';
    TRUNCATE TABLE silver.crm_prd_info;
    SELECT ">> Inserting Data Into: silver.crm_prd_info" AS '';
    INSERT INTO silver.crm_prd_info (
        prd_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt
    )
    SELECT
        prd_id,
        SUBSTRING(prd_key, 7),
        prd_nm,
        IFNULL(prd_cost, 0),
        CASE 
            WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
            WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
            WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
            WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
            ELSE 'n/a'
        END,
        prd_start_dt,
        NULL
    FROM bronze.crm_prd_info;
    SET end_time = NOW();
    SELECT CONCAT(">> Load Duration: ", TIMESTAMPDIFF(SECOND, start_time, end_time), " seconds") AS '';
    SELECT CONCAT(">> Rows Inserted: ", ROW_COUNT()) AS '';

    -- silver.crm_sales_details
        -- silver.crm_sales_details
    SET start_time = NOW();
    SELECT ">> Truncating Table: silver.crm_sales_details" AS '';
    TRUNCATE TABLE silver.crm_sales_details;
    SELECT ">> Inserting Data Into: silver.crm_sales_details" AS '';

    INSERT INTO silver.crm_sales_details (
        sls_ord_num, sls_prd_key, sls_cust_id,
        sls_order_dt, sls_ship_dt, sls_due_dt,
        sls_sales, sls_quantity, sls_price
    )
    SELECT 
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        STR_TO_DATE(sls_order_dt, '%Y%m%d'),
        STR_TO_DATE(sls_ship_dt, '%Y%m%d'),
        STR_TO_DATE(sls_due_dt, '%Y%m%d'),
        IF(sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price),
           sls_quantity * ABS(sls_price),
           sls_sales),
        sls_quantity,
        IF(sls_price IS NULL OR sls_price <= 0,
           sls_sales / NULLIF(sls_quantity, 0),
           sls_price)
    FROM bronze.crm_sales_details
    WHERE sls_order_dt REGEXP '^[0-9]{8}$'
      AND sls_ship_dt REGEXP '^[0-9]{8}$'
      AND sls_due_dt REGEXP '^[0-9]{8}$'
      AND sls_order_dt NOT IN ('00000000', '0')
      AND sls_ship_dt NOT IN ('00000000', '0')
      AND sls_due_dt NOT IN ('00000000', '0');

    SET end_time = NOW();
    SELECT CONCAT(">> Load Duration: ", TIMESTAMPDIFF(SECOND, start_time, end_time), " seconds") AS '';
    SELECT CONCAT(">> Rows Inserted: ", ROW_COUNT()) AS '';

    -- silver.erp_cust_az12
    SET start_time = NOW();
    SELECT ">> Truncating Table: silver.erp_cust_az12" AS '';
    TRUNCATE TABLE silver.erp_cust_az12;
    SELECT ">> Inserting Data Into: silver.erp_cust_az12" AS '';
    INSERT INTO silver.erp_cust_az12 (
        cid, bdate, gen
    )
    SELECT 
        IF(LEFT(cid, 3) = 'NAS', SUBSTRING(cid, 4), cid),
        IF(bdate > CURDATE(), NULL, bdate),
        CASE 
            WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
            WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
            ELSE 'n/a'
        END
    FROM bronze.erp_cust_az12;
    SET end_time = NOW();
    SELECT CONCAT(">> Load Duration: ", TIMESTAMPDIFF(SECOND, start_time, end_time), " seconds") AS '';
    SELECT CONCAT(">> Rows Inserted: ", ROW_COUNT()) AS '';

    -- silver.erp_loc_a101
    SET start_time = NOW();
    SELECT ">> Truncating Table: silver.erp_loc_a101" AS '';
    TRUNCATE TABLE silver.erp_loc_a101;
    SELECT ">> Inserting Data Into: silver.erp_loc_a101" AS '';
    INSERT INTO silver.erp_loc_a101 (
        cid, cntry
    )
    SELECT 
        REPLACE(cid, '-', ''),
        CASE 
            WHEN TRIM(cntry) = 'DE' THEN 'Germany'
            WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
            WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
            ELSE TRIM(cntry)
        END
    FROM bronze.erp_loc_a101;
    SET end_time = NOW();
    SELECT CONCAT(">> Load Duration: ", TIMESTAMPDIFF(SECOND, start_time, end_time), " seconds") AS '';
    SELECT CONCAT(">> Rows Inserted: ", ROW_COUNT()) AS '';

    -- silver.erp_px_cat_g1v2
    SET start_time = NOW();
    SELECT ">> Truncating Table: silver.erp_px_cat_g1v2" AS '';
    TRUNCATE TABLE silver.erp_px_cat_g1v2;
    SELECT ">> Inserting Data Into: silver.erp_px_cat_g1v2" AS '';
    INSERT INTO silver.erp_px_cat_g1v2 (
        id, cat, subcat, maintenance
    )
    SELECT 
        id, cat, subcat, maintenance
    FROM bronze.erp_px_cat_g1v2;
    SET end_time = NOW();
    SELECT CONCAT(">> Load Duration: ", TIMESTAMPDIFF(SECOND, start_time, end_time), " seconds") AS '';
    SELECT CONCAT(">> Rows Inserted: ", ROW_COUNT()) AS '';

    -- Final Summary
    SET batch_end_time = NOW();
    SELECT "==========================================" AS '';
    SELECT "Loading Silver Layer is Completed" AS '';
    SELECT CONCAT("   - Total Load Duration: ", TIMESTAMPDIFF(SECOND, batch_start_time, batch_end_time), " seconds") AS '';
    SELECT "==========================================" AS '';
END //

DELIMITER ;

CALL silver_load_silver();
SELECT COUNT(*) FROM silver.crm_sales_details;
SELECT COUNT(*) FROM silver.crm_prd_info;
SELECT COUNT(*) FROM silver.erp_cust_az12;
SELECT COUNT(*) FROM silver.erp_loc_a101;
SELECT COUNT(*) FROM silver.erp_px_cat_g1v2;
