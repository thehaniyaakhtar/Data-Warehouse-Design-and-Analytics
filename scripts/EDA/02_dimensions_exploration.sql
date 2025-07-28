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
