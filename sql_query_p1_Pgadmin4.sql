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

SELECT
	*
FROM
	retail_sales_tb
WHERE  
	transactions_id IS NULL
	OR 
	sale_date IS NULL 
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL 
	OR
	price_per_unit IS NULL 
	OR 
	cogs IS NULL
	OR 
	total_sale IS NULL
	;
-- Data Cleaning

DELETE 
FROM 
	retail_sales_tb 
WHERE  
	transactions_id IS NULL
	OR 
	sale_date IS NULL 
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR 
	quantiy IS NULL 
	OR
	price_per_unit IS NULL 
	OR 
	cogs IS NULL
	OR 
	total_sale IS NULL
	;
-- Data Exploration

-- How many sales we have ?
SELECT 
	count(*) 
AS 
	total_sales 
FROM 
	retail_sales_tb rst ,

-- How many unique customers do we have?
SELECT
	count(DISTINCT category) 
AS
	total_sales
FROM 
	retail_sales_tb ;
SELECT
	DISTINCT category 
FROM 
	retail_sales_tb  ;
-- Data Analysis & Business key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT 
	*
FROM
	retail_sales_tb 
WHERE
	sale_date = '2022-11-05' 
;
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT 
	*
FROM 
retail_sales_tb
WHERE 
		category = 'Clothing'
	AND 
		to_char(sale_date,'YYYY-MM') = '2022-11'
	AND 
		quantiy >= 4 
;
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) AS net_sale,
	COUNT(*) AS total_orders
FROM 
	retail_sales_tb 
GROUP BY 
	1 
;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	round(avg(age), 2) AS avg_age
FROM 
	retail_sales_tb
where
	category = 'Beauty'
;
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT
	*
FROM
	retail_sales_tb 
WHERE
	total_sale > 1000
;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
	count(*) AS total_trans
FROM
retail_sales_tb 
GROUP BY 
	category,
	gender
ORDER 
	BY 1
;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	YEAR,
	MONTH,
	avg_sale
FROM 
(
	SELECT  
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		sum(total_sale) AS avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM 
		retail_sales_tb 
	GROUP BY 1, 2
	ORDER BY 1, 3 DESC
) AS t1	

WHERE rank =1
;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales_tb
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales_tb
GROUP BY category
;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales
AS
(
SELECT 
	*,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 
			THEN
				'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 
			THEN
				'Afternoon'
		ELSE 
			'Evening'
	END AS shift
FROM
	retail_sales_tb

	;
	
	
	
