# Walmart Sales Data Analysis

## Project Overview
This project aims to explore Walmart's sales data to understand top-performing branches and products, identify sales trends, and analyze customer behavior. The goal is to determine how sales strategies can be improved and optimized. The dataset includes historical sales data from 45 Walmart stores located in various regions, with selected holiday markdown events included, complicating sales predictions.

## Purposes of the Project
The primary aim of this project is to gain insights into Walmart's sales data, focusing on the different factors that affect sales across various branches.

## Analysis List
### Product Analysis
Conduct an analysis to identify different product lines, evaluate which are performing best, and determine which need improvement.

### Sales Analysis
This analysis will explore product sales trends, helping to measure the effectiveness of current sales strategies and suggesting modifications for increased sales.

### Customer Analysis
Uncover different customer segments, purchasing trends, and the profitability of each segment.

## Approach Used
- 1. **Data Wrangling and Management Steps:**
  - **Data Inspection:** Inspected the dataset to identify NULL and missing values for a clean analysis.
  - **Database Management:** Built a database and created tables with appropriate data types.
  - **Data Insertion:** Inserted the cleaned data into the database, ensuring all fields were set to NOT NULL.
- 2. **Feature Engineering:** This will help use generate some new columns from existing ones.
   1. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
   2. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
   3. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
- 3. **Exploratory Data Analysis (EDA)**: Conducted to address the project’s key questions.

## Technologies Used
The primary technology used is **SQL**. Here are the specific SQL-related aspects:
- **Database Management**: Creating and managing a database (e.g., `CREATE DATABASE walmartSales;`).
- The Databse is created [Create_DB](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Creating%20DB%20Walmart.sql)

- **Table Creation**: Defining the schema for the sales data, including columns and data types (e.g., `CREATE TABLE sales (...);`).
- **Data Insertion**: Inserting the sales data into the created tables using `INSERT` statements.
- **Data Queries**: Running various `SELECT` queries to retrieve insights from the data, such as:
  - Unique cities
  - Total revenue by month
  - Most common product lines
  - Customer segmentation
- **Data Manipulation**: Using SQL functions to aggregate data, calculate totals, derive metrics (e.g., `SUM()`, `AVG()`, `GROUP BY`), And using Advanced SQL like subqueries and CTEs to reduce the time takesn to retrive the data.
- **Joins**: Using `JOIN` statements to combine data from multiple tables for deeper analysis.
- **Stored Procedures/Functions**: Writing procedures or functions to automate repetitive tasks or complex calculations.

Overall, SQL serves as the sole technology for managing, analyzing, and deriving insights from the Walmart sales data.

## The Dataset
The dataset, obtained from the [here](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting), contains sales transactions from three branches located in Mandalay, Yangon, and Naypyitaw. It includes 17 columns and 1,000 rows:

| Column                    | Description                                | Data Type       |
|---------------------------|--------------------------------------------|-----------------|
| invoice_id                | Invoice of the sales made                  | VARCHAR(30)     |
| branch                    | Branch at which sales were made            | VARCHAR(5)      |
| city                      | Location of the branch                     | VARCHAR(30)     |
| customer_type             | Type of the customer                       | VARCHAR(30)     |
| gender                    | Gender of the customer making purchase     | VARCHAR(10)     |
| product_line              | Product line of the sold product           | VARCHAR(100)    |
| unit_price                | Price of each product                      | DECIMAL(10, 2)  |
| quantity                  | Amount of the product sold                 | INT             |
| VAT                       | Tax on the purchase                        | FLOAT(6, 4)     |
| total                     | Total cost of the purchase                 | DECIMAL(10, 2)  |
| date                      | Date of purchase                           | DATE            |
| time                      | Time of purchase                           | TIMESTAMP       |
| payment_method            | Amount paid                                | DECIMAL(10, 2)  |
| cogs                      | Cost of Goods Sold                         | DECIMAL(10, 2)  |
| gross_margin_percentage   | Gross margin percentage                    | FLOAT(11, 9)    |
| gross_income              | Gross Income                               | DECIMAL(10, 2)  |
| rating                    | Customer rating                            | FLOAT(2, 1)     |

## Business Questions to Answer
### General Questions
1. How many unique cities does the data have?
2. In which city is each branch located?

### Product Questions
1. How many unique product lines are there?
2. What is the most common payment method?
3. What is the best-selling product line?
4. What is the total revenue by month?
5. Which month had the largest COGS?
6. Which product line generated the most revenue?
7. What city had the largest revenue?
8. Which product line had the highest VAT?
9. How can we categorize each product line as "Good" or "Bad" based on average sales?
10. Which branch sold more products than the average?
11. What is the most common product line by gender?
12. What is the average rating for each product line?
13. Which product line has the highest customer rating on average, considering only those with at least 10 sales?
- [Products](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Products.sql)

## Dashboard Preview
![image](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Products_Dashboard.jpg)
### Insightsgit
- **Top Sellers:** Electronic accessories are the most frequently purchased products, particularly by non-members.
- **Seasonal Trends:** High purchase volumes of sports products in January, food and beverages in February, and home and lifestyle items in March.
- **Demographics:** Females buy more than males, with a strong preference for fashion and accessories; males predominantly purchase health and beauty items.
- **Membership Trends:** Members tend to buy food and beverages in greater quantities, while non-members focus on electronic accessories.

### Recommended Strategy for Enhanced Sales
**Target Audience:** Focus on non-members purchasing electronic accessories and females for fashion and accessories.

**Marketing Strategy:**
- **Membership Promotions:** Encourage non-members to become members through exclusive offers on high-quantity products.
- **Seasonal Campaigns:**
  - **January:** Promote high-volume sales of sports products.
  - **February:** Emphasize bulk purchasing options for food and beverages.
  - **March:** Highlight home and lifestyle products with multi-buy discounts.
- **Gender-Specific Marketing:** Tailor campaigns for females focusing on fashion and accessories, and for males on health and beauty.
- **Cross-Selling:** Recommend complementary products to increase purchase quantities.

By aligning strategies with these insights, you can effectively boost the quantity of products sold.

## Sales Questions
1. How many sales were made at different times of the day on weekdays?
2. Which customer type generates the most revenue?
3. Which city has the highest VAT percentage?
4. Which customer type pays the most VAT?
- [Sales](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Sales.sql)

## Dashboard Preview
![image](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Sales_Dashboard.jpg )

### Insights
- The highest sales occur in the afternoons, indicating a peak purchasing time for customers.
- Saturdays are the top sales day, contributing significantly to overall sales figures.
- January shows strong sales performance, likely due to post-holiday shopping behavior.
- Sales in Naypyitaw City are notably high, making it a key market for targeted efforts.
- Sales Trends Across Dates: Analysis reveals patterns in daily sales, helping to identify fluctuations and seasonal peaks.

### Recommended Strategy for Enhanced Sales
**Target Audience:** Focus on afternoon shoppers, particularly on Saturdays and during January. Emphasize outreach in Naypyitaw City to capitalize on local demand.

**Marketing Strategy:**
- Implement afternoon promotions and exclusive Saturday deals to attract customers during peak hours.
- Create targeted marketing campaigns in January that highlight post-holiday offers.
- Utilize local advertising and community events in Naypyitaw City to strengthen brand presence and drive traffic.
- By aligning marketing efforts with these insights, sales can be significantly boosted by leveraging peak purchasing behaviors and local market strengths.


### Customer Questions
1. How many unique customer types are there?
2. How many unique payment methods are present?
3. What is the most common customer type?
4. Which customer type has the highest purchase volume?
5. What is the gender distribution of customers?
6. What is the gender distribution by branch?
7. At what time do customers give the highest ratings?
8. Which day of the week has the best average ratings?
9. Which day of the week has the highest ratings per branch?
10. How many sales were made on the best days for good ratings?
- [Customers](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Customers.sql)

## Dashboard Preview
![image](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/Customers_Dashboard.jpg)
### Insights
- **Customer Ratings:** Food and beverages receive the highest ratings, indicating strong customer satisfaction in this category.
- **Payment Methods:** Payment distribution is as follows: Cash (35%), E-Wallet (34%), Credit Card (31%).
- **Gender Distribution:** Females outnumber males in purchases and spend more on food and beverages, while males primarily spend on health and beauty products.
- **Spending Patterns:** Members show a preference for food and beverages, whereas non-members primarily purchase electronic accessories.

### Recommended Strategy for Enhanced Sales
**Target Audience:** Focus on female customers for food and beverages and engage male customers for health and beauty products.

### Marketing Strategy:

- **Highlight Food and Beverages:** Leverage high ratings to promote food and beverage products through targeted campaigns.
- **Payment Promotions:** Encourage the use of cash and e-wallets with incentives or discounts, considering their popularity.
- **Gender-Specific Campaigns:** Tailor marketing efforts for females around food and beverages and for males around health and beauty.
- **Membership Benefits:** Promote member-exclusive offers on food and beverages to increase loyalty and repeat purchases.
- **Non-Member Conversion:** Create campaigns to convert non-members purchasing electronic accessories into members by highlighting the benefits of membership, particularly in food and beverages.

Implementing these strategies can effectively enhance customer engagement and drive sales growth.


## Revenue and Profit Calculations
- **COGS** = unit_price × quantity
- **VAT** = 5% × COGS
- **Total (Gross Sales)** = VAT + COGS
- **Gross Profit (Gross Income)** = Total (Gross Sales) - COGS
- **Gross Margin** = (Gross Income / Total Revenue) × 100

### Example Calculation
**Data Given**:
- Unit Price = 45.79
- Quantity = 7

**Calculations**:
- COGS = 45.79 × 7 = 320.53
- VAT = 5% × COGS = 5% × 320.53 = 16.03
- Total = VAT + COGS = 16.03 + 320.53 = 336.56
- Gross Margin Percentage = (Gross Income / Total Revenue) = (16.03 / 336.56) ≈ 4.76%


## Code
For all SQL Queries, check the [SQL_queries.sql](https://github.com/Ak-AlphaData/SQL-Projects/blob/main/Walmart%20Sales%20Data%20Analysis/SQL_queries.sql) file

## Overall Insights for Walmart Sales
- **Top Sellers:** Electronic accessories are frequently purchased, especially by non-members. Food and beverages receive high customer ratings, indicating strong satisfaction.
- **Seasonal Trends:**
  - **January:** High sales of sports products, likely due to post-holiday shopping.
  - **February:** Strong demand for food and beverages, particularly around Valentine's Day.
  - **March:** Increased purchases of home and lifestyle items, signaling spring cleaning.
- **Demographics:** Females outnumber males in purchases, spending more on food and beverages, while males primarily buy health and beauty products.
- **Membership Trends:** Members generally buy more food and beverages; non-members focus on electronic accessories.
- **Peak Purchasing Times:** Highest sales occur in the afternoons, with Saturdays as the top sales day.
- **Sales Trends Across Dates:** Analysis reveals patterns in daily sales, helping to identify fluctuations and seasonal peaks.
- **Payment Methods:** Preferred methods are Cash (35%), E-Wallet (34%), and Credit Card (31%), indicating a need for payment-focused incentives.

### Recommended Strategy for Enhanced Sales
- **Target Audience:** Focus on non-members purchasing electronic accessories, afternoon shoppers, and females for food and beverages.

**Marketing Strategy:**
- **Membership Promotions:** Convert non-members through exclusive offers on high-quantity products.
- **Seasonal Campaigns:**
  - **January:** Promote sports products.
  - **February:** Highlight food and beverage bundles for Valentine’s Day.
  - **March:** Offer multi-buy discounts on home and lifestyle products.
- **Gender-Specific Marketing:** Tailor campaigns for females around food and beverages, and for males focusing on health and beauty.
- **Cross-Selling Strategies:** Recommend complementary products at checkout.
- **Afternoon Promotions:** Implement deals during peak hours and exclusive Saturday sales.
- **Payment Incentives:** Encourage cash and e-wallet usage with discounts or loyalty points.

Implementing these strategies will enhance customer engagement and drive significant sales growth for Walmart.

## Conclusion
The Walmart Sales Data Analysis project yielded valuable insights into sales performance, customer behavior, and product trends across various branches. By utilizing a comprehensive dataset from 45 stores, we identified critical factors affecting sales and developed targeted strategies for optimization.

The project highlights the importance of effective data management and visualization in enhancing decision-making processes. By implementing recommendations such as targeted marketing, seasonal promotions, and gender-specific campaigns, Walmart can boost sales and improve customer satisfaction and loyalty, positioning itself for sustained growth in a competitive market.