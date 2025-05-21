-- SQL RETAIL SALES ANALYSIS -- P1

CREATE database IF NOT EXISTS SQL_PROJECT_P1;
USE SQL_PROJECT_P1;

-- CREATING TABLE 

DROP TABLE if exists RETAIL_SALES;
CREATE table RETAIL_SALES (

	transactions_id int PRIMARY KEY,
	sale_date DATE,
	sale_time TIME, 
	customer_id INT,
	gender VARCHAR (15),
	age INT,
	category varchar (50),
	quantiy INT,
	price_per_unit float,
	cogs float,
	total_sale float

);

select * FROM RETAIL_SALES
LIMIT 15;

-- Checking total count of table --
SELECT COUNT(*) FROM RETAIL_SALES;

-- Checking Null values in columns -- Data Cleaning
SELECT * FROM RETAIL_SALES
WHERE 
	COGS IS NULL
    or
    transactions_id IS NULL
    or
    sale_Date IS NULL
    or
    sale_time IS NULL
    or
    customer_id IS NULL
    or
    gender IS NULL
    or
    age IS NULL
    or
    category IS NULL
    ; 

-- Checking Null values in bulk cmd on columns -- Data Cleaning
SELECT * FROM RETAIL_SALES
WHERE CONCAT(COGS, transactions_id, sale_Date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, total_sale) IS NULL;

-- Data Exploration --

-- How many sales we have ?
SELECT COUNT(*) AS TOTAL_SALE FROM retail_sales;

-- How many CUSTOMER we have ?
SELECT COUNT(DISTINCT customer_id) AS TOTAL_SALE FROM retail_sales;

SELECT COUNT(DISTINCT category) FROM retail_sales;

SELECT DISTINCT (category) FROM retail_sales;

-- Data Analysis -  Business Key problem & Answer --
-- My Analysis & Findings --
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where sale_date= '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category= 'CLOTHING' AND quantiy = 2 AND month(sale_date) = 11;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) 
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT category, avg(AGE) FROM retail_sales
where category = 'BEAUTY';
    
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
	
SELECT * FROM retail_sales
WHERE total_sale >1000;    

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT CATEGORY,GENDER, count(transactions_id) FROM retail_sales
group by category, GENDER
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * FROM 
(
	SELECT
		year(sale_date) as Year,
		MONTH(sale_date) as month ,
		round(avg(total_sale),2) as Avg_sale, 
		RANK() OVER (partition by  year(sale_date) ORDER BY  round(avg(total_sale),2) DESC) AS RANKING -- New function to derive rank system
		
	FROM retail_sales
	GROUP BY 
		year(sale_date),
		month(sale_date)
    ) AS T1    				-- We had made sub query for ranking system
    
    WHERE RANKING =1;
    
    
    
    
-- order by 1,3 desc;  -- This line tells best selling month in each year


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
	customer_id as Customer, 
    sum(total_sale) as Total_sales
FROM retail_sales
	group by 1
	order by 2 desc
    limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
	category,
	 count(distinct(customer_id)) AS UNIQUE_CUSTOMER
from retail_sales
	group by 1;
	

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS Shift,
  COUNT(*) AS number_of_orders
FROM
  retail_sales
GROUP BY
  shift;
  
  
  -- End of Project----
  

