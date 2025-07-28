/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

USE DataWarehouseAnalytics;

SELECT * 
FROM gold_dim_customers;

SELECT DISTINCT country
FROM gold_dim_customers
ORDER BY country;

SELECT * 
FROM gold_dim_products;

SELECT DISTINCT category, subcategory, product_name
FROM gold_dim_products
ORDER BY category, subcategory
;
