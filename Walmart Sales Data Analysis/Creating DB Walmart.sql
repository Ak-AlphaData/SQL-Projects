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
-- Open MySQL Workbench and connect to your database.

-- Right-click on the target database in the Navigator panel on the left.

-- Select "Table Data Import Wizard" from the context menu.

-- Locate your CSV file:

-- Click "Browse" to select your CSV file.
-- Select the target table:

-- Choose an existing table or create a new one as needed.
-- Map the columns (if required):

-- Ensure the CSV columns align with the table columns. Make adjustments if necessary.
-- Finish the import:

Review your settings, click "Next", then "Finish" to complete the import process.
-- Step3: Data cleaning
SELECT
	*
FROM sales;


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
FROM sales;S

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM sales;
