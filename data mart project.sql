create database datamart;
use datamart;
-- data cleansing
create table clean_weekly_sales as
select week_date,week(week_date) as week_mumber,month(week_date) as month_number,
year(week_date) as calendar_year,region,platform,
case when segment = null then "Unknown" else segment end as segment ,
case 
when right(segment,1)= '1' then "Young Adults" 
when right(segment,1)= '2' then "Middle Aged"
when right(segment,1) in ('3','4') then "Retirees"
else "Unknown" end as age_band,
case
when left(segment,1) = "C" then "Couples"
when left(segment,1) = "F" then "Families"
else "Unknown" end as demographic,
customer_type,transactions,sales, round(sales/transactions,2) as 'avg_transaction'
from weekly_sales;

select * from clean_weekly_sales limit 10;

-- Data Exploration
-- q1 Which week numbers are missing from the dataset?

create table seq100 (x int auto_increment primary key);
insert into seq100 values(),(),(),(),(),(),(),(),(),();
insert into seq100 values(),(),(),(),(),(),(),(),(),();
insert into seq100 values(),(),(),(),(),(),(),(),(),();
insert into seq100 values(),(),(),(),(),(),(),(),(),();
insert into seq100 values(),(),(),(),(),(),(),(),(),();
insert into seq100 select x+50 from seq100;
select * from seq100;

create table seq52 as (select x from seq100 limit 52);
select * from seq52;
select distinct x as week_day from seq52
where x not in ( select distinct week_mumber from clean_weekly_sales);

select distinct week_mumber from clean_weekly_sales;  ## weeknumber which are present in cleaned data 

-- q2 How many total transactions were there for each year in the dataset?

SELECT calendar_year, SUM(transactions) AS total_transactions
FROM clean_weekly_sales
GROUP BY calendar_year
LIMIT 0, 1000;

-- q3 What are total sales for each region for each month?
select region,month_number,sum(sales) as total_sales
from clean_weekly_sales 
group by month_number,region;

-- q4 What is the total count of transactions for each platform?

select platform,sum(transactions) as total_transactions
 from clean_weekly_sales
group by platform;

-- q5 What is the percentage of sales for Retail vs Shopify for each month?
WITH cte_monthly_platform_sales AS (
    SELECT month_number,calendar_year,platform, SUM(sales) AS monthly_sales
    FROM clean_weekly_sales
    GROUP BY month_number,calendar_year,platform)
SELECT month_number,calendar_year,
    ROUND(100 * MAX(CASE WHEN platform = "Retail" THEN monthly_sales ELSE NULL END) / SUM(monthly_sales), 2) AS retail_percentage,
    ROUND(100 * MAX(CASE WHEN platform = "Shopify" THEN monthly_sales ELSE NULL END) / SUM(monthly_sales), 2) AS Shopify_percentage
FROM cte_monthly_platform_sales
GROUP BY month_number,calendar_year;

-- q6 What is the percentage of sales by demographic for each year in dataset?
SELECT calendar_year,demographic,SUM(sales) AS yearly_sales,
ROUND(100 * SUM(sales) / SUM(SUM(sales)) OVER (PARTITION BY demographic), 2) AS percentage
FROM clean_weekly_sales
GROUP BY calendar_year,demographic;

-- q7 Which age band and demographic values contribute the most to Retail sales?
select age_band,demographic,sum(sales) as total_sales
from clean_weekly_sales
where platform = "Retail"
group by age_band,demographic
order by total_sales desc;














