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
