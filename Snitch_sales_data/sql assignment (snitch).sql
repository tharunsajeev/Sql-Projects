create database snitchh;
use snitchh;
drop database snitchh;

select * from snitch_data;

select  distinct year(orderdate) from snitch_data order by 'orderdate' desc;

desc snitch_data;

ALTER TABLE snitch_data
MODIFY order_date DATE;

-- correcting city
select distinct(city) from snitch_data;
update snitch_data set city = 'Hyderabad' where lower(city) in ('hyd','hyderbad');
update snitch_data set city = 'Bengaluru' where lower(city) in ('bangalore');

select * from snitch_data;

select distinct(order_month) from snitch_data where order_year = 2023;

-- 1
-- total sales revenue
select round(sum(sales_amount),2) as total_revenue from snitch_data;

-- 2
-- total sales revenue per year
select order_year, round(sum(sales_amount),2) as total_revenue from snitch_data group by order_year order by order_year asc;

-- 3
-- total sales revenue by month per year
select * from snitch_data;
select order_month,order_year, sum(sales_amount) as total_revenue from snitch_data group by order_year,order_month order by order_year;

-- for 2023
select order_month,order_year,round(sum(sales_amount),2) as monthly_revenue from snitch_data where order_year = 2023 group by order_month order by monthly_revenue desc limit 5;
-- for 2024
select order_month,order_year,round(sum(sales_amount),2) as monthly_revenue from snitch_data where order_year = 2024 group by order_month order by monthly_revenue desc limit 5;
-- for 2025
select order_month,order_year,round(sum(sales_amount),2) as monthly_revenue from snitch_data where order_year = 2025 group by order_month order by monthly_revenue desc limit 5;

-- 4
-- least sales revenue
select order_month,order_year,round(sum(sales_amount),2) as monthly_revenue from snitch_data where orderdate in(2023,2024,2025) group by order_month,order_year order by monthly_revenue desc limit 7;

-- 5
-- total revenue by city;
select city,round(sum(sales_amount),2) as total_revenue from snitch_data group by city order by total_revenue desc;

-- 6
-- top 5 best selling products
select * from snitch_data;
select * from ( select product_name, round(sum(units_sold)) as totalunits_sold, 
rank() over (order by sum(units_sold) desc) as product_rank from snitch_data group by product_name) ranked_products
where product_rank <=5;


-- 7
-- least selling products
select * from ( select product_name,product_category, round(sum(units_sold)) as totalunits_sold, 
rank() over (order by sum(units_sold) asc) as product_rank from snitch_data group by product_name,product_category) ranked_products
where product_rank <=5;

-- 8
-- most profitable products
select product_category , Product_name ,round(sum(profit),2) as total_profit from snitch_data group by product_category,Product_name order by total_profit desc limit 5;


-- 9 
-- total revenue by product category
select * from snitch_data;
select Product_category , round(sum(sales_amount),2) as total_revenue from snitch_data group by product_category order by total_revenue desc;

-- 10
-- Top profitable product categories
select Product_category ,round(sum(profit),2) as total_profit from snitch_data group by product_category order by total_profit desc limit 5;

-- 11
-- average discount vs profit
select * from snitch_data;
alter table snitch_data change `discount_%` discount_per double;
desc snitch_data;
select round(avg(discount_per),2) as avg_discount, round(sum(profit),2) as total_profit from snitch_data;

select order_year,round(avg(discount_per),2) as avg_discount, round(sum(profit),2) as total_profit from snitch_data where order_year in(2025,2024,2023) group by order_year order by total_profit desc;

-- 12
-- total profit by discounted products and non-discounted products
select case when discount_per >0
then 'Discounted'
else 'No Discount'
end as discount_status, round(avg(discount_per),2) as avg_discount, round(sum(profit),2) as total_profit from snitch_data group by discount_status;

-- 13
-- total revenue and profit by segment
select segment, round(sum(sales_amount),2) as total_revenue, round(sum(profit),2) as total_profit from snitch_data group by segment order by total_revenue desc;

-- 14
-- top customers by revenue
select * from snitch_data;
select customer_name, sum(sales_amount) as total_revenue from snitch_data group by customer_name order by total_revenue desc limit 5;

-- 15
-- most profit per discount percentage
select discount_per,round(avg(profit),2) as avg_profit from snitch_data group by discount_per order by avg_profit desc limit 5;

-- 16
-- top selling products from accessories
select product_name, sum(units_sold) as totalunits_sold from snitch_data where product_category = 'accessories' group by product_name order by totalunits_sold desc limit 5;









