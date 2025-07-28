/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

SELECT *
FROM gold_dim_products
;

SELECT *
FROM gold_dim_customers
;

SELECT *
FROM gold_fact_sales
;

SELECT 
	country,
    COUNT(customer_key) AS total_customers
FROM gold_dim_customers 
GROUP BY country
ORDER BY total_customers DESC
;

SELECT gender,
	   COUNT(customer_id)
FROM gold_dim_customers
GROUP BY gender
;

SELECT COUNT(product_name) AS total_prod,
	   category
FROM gold_dim_products
GROUP BY category
ORDER BY total_prod
;

SELECT AVG(cost) AS avg_cost,
	   category
FROM gold_dim_products
GROUP BY category
ORDER BY avg_cost
;

SELECT p.category,
	   SUM(f.sales_amount) AS total_revenue
FROM gold_fact_sales f
JOIN gold_dim_products p
	 ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue
;

SELECT c.country,
	   SUM(f.quantity) AS total_items
FROM gold_fact_sales f
JOIN gold_dim_customers c
	 ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC
;
