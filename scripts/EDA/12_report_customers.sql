/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

DROP VIEW IF EXISTS gold_report_customers;

CREATE VIEW gold_report_customers AS

WITH base_query AS (

    SELECT
        f.order_number,          
        f.product_key,         
        f.order_date,          
        f.sales_amount,        
        f.quantity,              

        c.customer_key,          
        c.customer_number,      
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,

        TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age

    FROM gold_fact_sales f
    LEFT JOIN gold_dim_customers c ON c.customer_key = f.customer_key

    WHERE f.order_date IS NOT NULL
),

customer_aggregation AS (
    SELECT
        customer_key,           
        customer_number,
        customer_name,
        age,


        COUNT(DISTINCT order_number) AS total_orders,

        -- Total sales amount across all purchases by this customer
        SUM(sales_amount) AS total_sales,

        -- Total number of units purchased by customer
        SUM(quantity) AS total_quantity,

        -- How many distinct products the customer has bought
        COUNT(DISTINCT product_key) AS total_products,

        -- Last order date of the customer
        MAX(order_date) AS last_order_date,

        -- Time span (in months) between first and last order
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan

    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age
)

SELECT
    customer_key,
    customer_number,
    customer_name,
    age,

    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS age_group,

 
    CASE
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'        -- Long-term + high spender
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'   -- Long-term + modest spender
        ELSE 'New'                                                   -- Recent customers
    END AS customer_segment,


    last_order_date,

    TIMESTAMPDIFF(MONTH, last_order_date, CURDATE()) AS recency,

    total_orders,

    total_sales,

    total_quantity,

    total_products,

    lifespan,

    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,

    CASE
        WHEN lifespan = 0 THEN total_sales    
        ELSE total_sales / lifespan
    END AS avg_monthly_spend

FROM customer_aggregation;

