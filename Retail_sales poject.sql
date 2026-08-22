
DROP TABLE IF EXISTS retail_sales;
-- CREATE TABLE
CREATE TABLE retail_sales
(	
	transactions_id	INT PRIMARY KEY,
	sale_date	DATE,
	sale_time	TIME,
	customer_id	INT,
	gender	VARCHAR(20),
	age		INT,
	category VARCHAR(20),	
	quantiy	 INT,
	price_per_unit	FLOAT,
	cogs	FLOAT,
	total_sale FLOAT
);

select *from retail_sales;


-- data cleaning
-- dealing with null values
select * from retail_sales
where 
	transactions_id	IS NULL
	OR
	sale_date	IS NULL
	OR
	sale_time	IS NULL
	OR
	customer_id	IS NULL
	OR
	gender	IS NULL
	OR
	age		IS NULL
	OR
	category IS NULL
	OR
	quantiy	 IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs	IS NULL
	OR
	total_sale IS NULL;

-- removing null values
	DELETE FROM retail_sales
	where 
		transactions_id	IS NULL
	OR
	sale_date	IS NULL
	OR
	sale_time	IS NULL
	OR
	customer_id	IS NULL
	OR
	gender	IS NULL
	OR
	age		IS NULL
	OR
	category IS NULL
	OR
	quantiy	 IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs	IS NULL
	OR
	total_sale IS NULL;

	-- no of total sales
	select count(*) from retail_sales;

	-- no of unique customers
	select count(distinct(customer_id))from retail_sales;

	-- no of unique category
	select distinct(category)unique_category from retail_sales;

	-- Data Analysis and solving bussiness problems
	 
-- 1. **Write a SQL query to retrieve all columns for sales made on `'2022-11-05'`.

select * from retail_sales 
where sale_date = '2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is `'Clothing'` and the quantity sold is more than 10 in the month of Nov-2022.
 
 select 
 	* 
 from retail_sales
 where 
 category='Clothing' 
 and quantiy >= 4
 and to_char(sale_date,'YYYY-MM')='2022-11';
 
-- 3. Write a SQL query to calculate the total sales (`total_sale`) for each category.

select category,sum(total_sale)as Total_sales
from retail_sales
group by category;

-- 4.Write a SQL query to find the average age of customers who purchased items from the `'Beauty'` category

 select 
 	round(avg(age),2) as Avg_age
 from retail_sales
 where category='Beauty';
-- 5.Write a SQL query to find all transactions where the `total_sale` is greater than 1000.
select 
	*
from retail_sales
where total_sale > 1000;


-- 6.Write a SQL query to find the total number of transactions (`transaction_id`) made by each gender in each category.
select 
	count(transactions_id)as total_transactions, 
	gender,
	category
	
from retail_sales
group by gender,category
order by total_transactions;



-- 7.Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.**
select * 
FROM 
(select 
	EXTRACT(YEAR FROM SALE_DATE)As year,
	EXTRACT(MONTH FROM SALE_DATE)AS month,
	avg(total_sale)AS Average_sales,
	RANK() over(partition by EXTRACT(YEAR FROM SALE_DATE) order by avg(total_sale) desc )as ranking
from 
	retail_sales
	group by 
		year,month)AS T
	where ranking=1
	

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.
select
	customer_id,
	sum(total_sale)as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.**
select 
	count(DISTINCT(customer_id))as customers,
	category
from 
	retail_sales
	group 	
		by category;
-- 10.Write a SQL query to create each shift and number of orders.(Morning: `<= 12` Afternoon: `Between 12 & 17` Evening: `> 17`)
WITH hourly_sales
AS
(
select * ,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) <=12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT
from retail_sales
)
select 
	shift,
	count(*) as Total_sales
from hourly_sales
group by shift;











	