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