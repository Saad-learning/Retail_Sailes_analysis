--SQL Retail Sales analysis - p1
 CREATE DATABASE sql_project_p1;
 
 --Create TABLE
 CREATE TABLE retail_sales_tb
 				(
				transactions_id	INT PRIMARY KEY,
				sale_date	DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	VARCHAR(10),
				age	INT,
				category	VARCHAR(15),
				quantiy	INT,
				price_per_unit	FLOAT,
				cogs FLOAT,
				total_sale	FLOAT
 				);

SELECT * FROM retail_sales_tb