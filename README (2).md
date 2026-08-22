# Retail Sales Analysis — SQL Project

## 📌 Project Overview

This project analyzes **retail sales data using SQL** to extract meaningful business insights from sales transactions.

The project demonstrates practical SQL skills such as data exploration, filtering, aggregation, grouping, sorting, conditional logic, subqueries, and analytical queries.

The goal is to transform raw retail sales data into useful insights that can help understand sales performance, customer behavior, product performance, and overall business trends.

## 🎯 Objectives

- Explore and understand retail sales data.
- Clean and prepare data for analysis.
- Calculate key sales metrics.
- Analyze sales by different categories and dimensions.
- Identify top-performing products/customers/categories.
- Use SQL queries to answer real-world business questions.
- Practice intermediate and advanced SQL concepts.

## 🛠️ Technologies Used

- **SQL**
- **MySQL / SQL-compatible database**
- SQL concepts including:
  - `SELECT`
  - `WHERE`
  - `ORDER BY`
  - `GROUP BY`
  - `HAVING`
  - Aggregate functions
  - `CASE`
  - Subqueries
  - Joins
  - Window functions
  - Date functions

## 📂 Project Structure
### 1. Database Setup
- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
```sql
CREATE DATABASE sql_project_p1;
DROP TABLE IF EXISTS retail_sales;
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
```
### 2. Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
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

```
### 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:
1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales 
where sale_date = '2022-11-05';
```
2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select 
 	* 
 from retail_sales
 where 
 category='Clothing' 
 and quantiy >= 4
 and to_char(sale_date,'YYYY-MM')='2022-11';
```
3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category,sum(total_sale)as Total_sales
from retail_sales
group by category;

```
4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
 	round(avg(age),2) as Avg_age
 from retail_sales
 where category='Beauty';
```
5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select 
	*
from retail_sales
where total_sale > 1000;
```
6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select 
	count(transactions_id)as total_transactions, 
	gender,
	category
	
from retail_sales
group by gender,category
order by total_transactions;
```
7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
	
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select
	customer_id,
	sum(total_sale)as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;
```
9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
	count(DISTINCT(customer_id))as customers,
	category
from 
	retail_sales
	group 	
		by category;
```
10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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


```

## 🗃️ Dataset

The project uses a retail sales dataset containing transaction-level information.

The SQL script includes the database/table setup, data preparation, and analytical queries required to perform the analysis.

### Tables

- `retail_sales`

## 🔍 Analysis Performed

The project covers several types of retail-sales analysis, including:

### Sales Analysis
- Total sales/revenue calculation
- Sales aggregation
- Sales comparison
- Sorting transactions by sales amount

### Product Analysis
- Identifying high-performing products
- Comparing product/category performance
- Finding top and low-performing items

### Customer Analysis
- Analyzing customer purchase behavior
- Identifying customers based on purchase activity/value

### Time-Based Analysis
- Analyzing sales using transaction dates
- Comparing sales across different periods

### Advanced SQL Analysis
- Conditional calculations using `CASE`
- Subqueries for complex business questions
- Ranking and analytical calculations using window functions where applicable

## ▶️ How to Run the Project

### 1. Install MySQL

Install **MySQL Server** and a SQL client such as MySQL Workbench.

### 2. Open the SQL Script

Open:

```text
Retail sales poject.sql
```

in MySQL Workbench or your preferred SQL environment.

### 3. Execute the Script

Run the SQL statements in sequence to:

1. Create/select the database.
2. Create the required table(s).
3. Insert or load the data.
4. Execute the analysis queries.

### 4. View the Results

Execute the analytical queries and review the returned result sets.

## 💡 Key SQL Skills Demonstrated

This project demonstrates practical knowledge of:

- Data retrieval
- Data filtering
- Data aggregation
- Grouping and sorting
- Conditional logic
- Date-based analysis
- Subqueries
- Joins
- Window functions
- Business-oriented SQL problem solving

## 📊 Project Outcome

The analysis converts raw retail transaction data into structured information that can be used to understand sales performance and identify important business patterns.

This project is also a practical demonstration of applying SQL to a real-world business analytics problem.

## 🚀 Future Improvements

Possible improvements include:

- Add more detailed customer segmentation.
- Perform monthly and yearly sales trend analysis.
- Calculate customer lifetime value.
- Add product/category profitability analysis.
- Connect the SQL database to **Power BI** for interactive dashboards.
- Automate regular sales reports.
- Add more advanced window-function analysis.

## 📁 Repository Contents

| File | Description |
|---|---|
| `Retail sales poject.sql` | SQL database setup, data, and analysis queries |
| `README.md` | Project documentation |

## 👨‍💻 Author

**Sandeep Kumar**

B.Tech — Artificial Intelligence & Machine Learning

---

⭐ If you find this project useful, feel free to star the repository!
