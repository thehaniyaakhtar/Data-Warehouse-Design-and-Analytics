/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

DROP database IF EXISTS DataWarehouseAnalytics;
CREATE DATABASE DataWarehouseAnalytics;
USE DataWarehouseAnalytics;

DROP TABLE IF EXISTS gold_dim_customers;
CREATE TABLE gold_dim_customers (
  customer_key INT,
  customer_id INT,
  customer_number VARCHAR(50),
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  country VARCHAR(50),
  marital_status VARCHAR(50),
  gender VARCHAR(50),
  birthdate DATE,
  create_date DATE
);

CREATE TABLE gold_fact_sales(
order_number VARCHAR(50),
product_key INT,
customer_key INT,
order_date DATE,
shipping_date DATE,
due_date DATE,
sales_amount INT,
quantity TINYINT,
price int
);

CREATE TABLE gold_dim_products (
product_key INT,
product_id INT,
product_number VARCHAR(50),
product_name VARCHAR(50),
category_id VARCHAR(50),
category VARCHAR (50),
subcategory VARCHAR(50),
maintenance VARCHAR(50),
cost INT,
product_line VARCHAR(50),
start_date DATE
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/theha/OneDrive/Desktop/SQL_DWH/datasets/csv-files/gold.fact_sales'
INTO TABLE gold_fact_sales
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/theha/OneDrive/Desktop/SQL_DWH/datasets/csv-files/gold.dim_products'
INTO TABLE gold_dim_products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/theha/OneDrive/Desktop/SQL_DWH/datasets/csv-files/gold.dim_customers'
INTO TABLE gold_dim_customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

SELECT * FROM gold_fact_sales LIMIT 5;
SELECT * FROM gold_dim_customers LIMIT 5;
SELECT * FROM gold_dim_products LIMIT 5;
