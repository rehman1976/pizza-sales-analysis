
CREATE TABLE PIZZA_SALES(
    
    pizza_id int primary key,
    order_id int,
    pizza_name_id varchar(50),
    quantity int,
    order_date date,
    order_time time,
    unit_price numeric(10, 2),
    total_price numeric(10, 2),
    pizza_size varchar(15),
    pizza_category varchar(25),
    pizza_name text,
    pizza_ingredients text
);

select * from PIZZA_SALES;

-- KPI

1.-- Total Revenue

SELECT SUM(total_price) AS total_revenue FROM PIZZA_SALES;

2.-- Total Orders

SELECT COUNT(DISTINCT order_id) AS total_orders FROM PIZZA_SALES;

3.-- Average Order Value

SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2)  AS average_order_value FROM PIZZA_SALES;

4.-- Total Pizzas Sold

SELECT SUM(quantity) AS total_pizza_sold FROM PIZZA_SALES;

5.-- Average Pizzas Per Order

SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS avg_pizza_per_order FROM PIZZA_SALES;


-- Trend & Distribution Analysis

6.-- Monthly Trend for Total Revenue

SELECT 
TO_CHAR(order_date, 'MONTH') AS month, 
SUM(total_price) AS total_revenue 
FROM PIZZA_SALES 
GROUP BY TO_CHAR(order_date, 'MONTH'), EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);

7.-- Daily Trend for Total Orders

SELECT 
TO_CHAR(order_date,'DAY') AS days,
COUNT(DISTINCT order_id) AS total_orders
FROM PIZZA_SALES
GROUP BY TO_CHAR(order_date,'DAY'), EXTRACT(ISODOW FROM order_date)
ORDER BY EXTRACT(ISODOW FROM order_date)

8.-- Percentage of Sales by Pizza Category

SELECT pizza_category,  round(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM PIZZA_SALES),2) AS sales_in_percentage 
FROM PIZZA_SALES
GROUP BY pizza_category

9.-- Percentage of Sales by Pizza Size

SELECT pizza_size,  round(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM PIZZA_SALES),2) AS sales_in_percentage 
FROM PIZZA_SALES
GROUP BY pizza_size

10.-- Total Pizzas Sold by Pizza Size and Category

SELECT pizza_category, pizza_size, SUM(quantity) AS total_pizza_sold from PIZZA_SALES
GROUP BY pizza_category, pizza_size
ORDER BY pizza_category;

11.-- Top 5 Pizza Names by Revenue

SELECT pizza_name, SUM(total_price) AS total_revenue FROM PIZZA_SALES
GROUP BY pizza_name
order by SUM(total_price) desc
limit 5;

--  Top / Bottom Analysis

12.-- Top Pizza by Revenue

SELECT pizza_name, SUM(total_price) AS total_revenue  FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY SUM(total_price) desc
LIMIT 1 ;

13.-- Worst Pizza by Revenue

SELECT pizza_name, SUM(total_price) AS total_revenue  FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY SUM(total_price) 
LIMIT 1 ;

14.-- top Pizza by Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY COUNT(DISTINCT order_id) DESC
LIMIT 1 ;


15.-- Worst Pizza by Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY COUNT(DISTINCT order_id)
LIMIT 1 ;

16.-- Top Pizza by Quantity Sold

SELECT pizza_name, SUM(quantity) AS total_quantity FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY SUM(quantity) DESC
LIMIT 1 ;

17.-- Worst Pizza by Quantity Sold

SELECT pizza_name, SUM(quantity) AS total_quantity FROM PIZZA_SALES
GROUP BY pizza_name 
ORDER BY SUM(quantity)
LIMIT 1 ;
