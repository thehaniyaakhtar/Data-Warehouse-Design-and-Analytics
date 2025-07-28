/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

SELECT *
FROM gold.fact_sales;

SELECT SUM(sales_amount) AS Total_Sales
FROM gold.fact_sales
;

SELECT SUM(quantity)
FROM gold.fact_sales
;

SELECT AVG(price) as avg_price
FROM gold.fact_sales
;

SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales
;

SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM gold_dim_customers
;

SELECT 'Total Sales' AS metric, SUM(sales_amount) AS value 
FROM gold_fact_sales

UNION ALL

SELECT 'Total Quantity', SUM(quantity) 
FROM gold_fact_sales

UNION ALL

SELECT 'Average Price', AVG(price)
FROM gold_fact_sales

UNION ALL

SELECT 'Total Orders', COUNT(DISTINCT order_number)
FROM gold_fact_sales

UNION ALL

SELECT 'Total Products', COUNT(DISTINCT product_key) 
FROM gold_fact_sales

UNION ALL

SELECT 'Total Customers', COUNT(*) 
FROM gold.dim_customers;

