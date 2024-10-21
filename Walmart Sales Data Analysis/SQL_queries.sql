-- Step1: Creating Database and its products for Walmartsales Database
-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;
use walmart;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);


-- Step2: Loading data fromsource dataset into Mysql server
-- Importing CSV Files in MySQL Workbench
-- 1. Open MySQL Workbench and connect to your database.
-- 2. Right-click on the target database in the Navigator panel on the left.
-- 3. Select "Table Data Import Wizard" from the context menu.
-- 4. Locate your CSV file:
-- 5. Click "Browse" to select your CSV file.
-- 6. Select the target table:
-- 7. Choose an existing table or create a new one as needed.
-- 8. Map the columns (if required):
-- 9. Ensure the CSV columns align with the table columns. Make adjustments if necessary.
-- 10. Finish the import:
-- Review your settings, click "Next", then "Finish" to complete the import process.


-- Step3: Data cleaning
SELECT
	*
FROM sales;

-- Adding a column for time of the day
-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- adding column for day of the week
-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Adding column of month of the year
-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);


-- ---------------------------- General Questions ------------------------------

-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM sales;

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;


-- ---------------------------- Product -------------------------------

-- 1. How many unique product lines does the data have?
SELECT
    DISTINCT product_line
FROM sales;

-- 2. What is the most common payment method?
SELECT
    payment,
    count(payment) as payment_method
FROM sales
GROUP BY payment
ORDER BY count(payment) DESC;

-- 3. What is the most selling product line?
SELECT
    SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- 4. What is the total revenue by month?
SELECT
    month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- 5. What month had the largest COGS?
SELECT
    month_name AS month,
    SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs desc;

-- 6. What product line had the largest revenue?
SELECT
    product_line,
    SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- 7. What is the city with the largest revenue?
SELECT
    branch,
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue desc;

-- 8. What product line had the largest VAT?
SELECT
    product_line,
    AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- 9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT 
    AVG(quantity) AS avg_qnty
FROM sales;

SELECT
    product_line,
    CASE
        WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;
-- Here this takes time of 0.016 sec

-- OR 

WITH avg_sales AS (
    SELECT AVG(quantity) AS avg_quantity
    FROM sales
)
SELECT product_line,
       CASE
           WHEN SUM(quantity) > (SELECT avg_quantity FROM avg_sales) THEN 'Good'
           ELSE 'Bad'
       END AS remark
FROM sales
GROUP BY product_line;
-- Here using CTE can reduce time of retriving data as we can see it takes 0.000 sec 

-- 10. Which branch sold more products than average product sold?
SELECT 
    branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) 
                        FROM sales);

-- 11. What is the most common product line by gender?
SELECT
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- 12. What is the average rating of each product line?
SELECT
    ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- 13. Which product line has the highest customer rating on average, considering only those with at least 10 sales?
SELECT product_line,
       ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
HAVING COUNT(quantity) >= 10  -- Ensure at least 10 sales
ORDER BY avg_rating DESC;


-- -------------------------- Customers -------------------------------

-- 1.How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- 2.How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM sales;

-- 3.What is the most common customer type?
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- 4.Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- 5.What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- 6.What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch IN ('a','b','c')
GROUP BY gender
ORDER BY gender_cnt DESC;
-- Gender per branch is more or less the same hence, I don't think has an effect of the sales per branch and other factors.

-- 7.Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its more or less the same rating each time of the day.alter

-- 8.Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating,
    Branch
FROM sales
-- WHERE branch in( "A","b","c")
GROUP BY time_of_day,branch
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a little more to get better ratings.

-- 9.Which day fo the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings why is that the case, how many sales are made on these days?

-- 10.Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;

-- 11.How many sales were made on the best days for good ratings?
WITH BestRatingDays AS (
    SELECT day_name
    FROM sales
    GROUP BY day_name
    HAVING AVG(rating) = (SELECT MAX(avg_rating)
                          FROM (SELECT AVG(rating) AS avg_rating
                                FROM sales
                                GROUP BY day_name) AS avg_ratings)
)

SELECT day_name, COUNT(*) AS total_sales
FROM sales
WHERE day_name IN (SELECT day_name FROM BestRatingDays)
GROUP BY day_name;


-- COUNT(DISTINCT): To count unique customer types and payment methods.
-- Common Table Expressions (CTEs): Used in query 11 for better readability and to avoid repeating logic.
-- Subqueries: Used to find the maximum average rating in query 11.

-- ---------------------------- Sales ---------------------------------

-- 1.Number of sales made in each time of the day per each weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name IN ('Sunday' ,'monday','tuesday','wensday','thursday','friday','saturday')
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are filled during the evening hours

-- 2.Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue desc;

-- 3.Which city has the largest tax/VAT (Value Added Tax) percent?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- 4.Which customer type pays the most in VAT(Value added tax)?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;


-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
