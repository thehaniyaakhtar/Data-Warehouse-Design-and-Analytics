/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

DROP DATABASE IF EXISTS DataWarehouse;
CREATE DATABASE DataWarehouse;
USE DataWarehouse;

CREATE TABLE Bronze (
	id INT PRIMARY KEY,
    value TEXT
);

CREATE TABLE Silver (
	id INT PRIMARY KEY,
    value TEXT
);

CREATE TABLE Gold(
	id INT PRIMARY KEY,
    value TEXT
);
