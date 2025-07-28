-- Monthly totals + running total + moving avg (over entire history)
SELECT
  order_month,
  total_sales,
  SUM(total_sales) OVER (ORDER BY order_month) AS running_total_sales,
  AVG(avg_price)  OVER (ORDER BY order_month) AS moving_average_price
FROM (
  SELECT
    CAST(DATE_FORMAT(order_date, '%Y-%m-01') AS DATE) AS order_month,
    SUM(sales_amount) AS total_sales,
    AVG(price)        AS avg_price
  FROM gold_fact_sales
  WHERE order_date IS NOT NULL
  GROUP BY CAST(DATE_FORMAT(order_date, '%Y-%m-01') AS DATE)
) AS t
ORDER BY order_month;

