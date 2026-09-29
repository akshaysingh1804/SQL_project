USE ecommerce_company;

SELECT * FROM customers;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM product;

DESC customers;
DESC orderdetails;
DESC orders;
DESC product;

UPDATE orders
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE orders
MODIFY COLUMN order_date DATE;

SET SQL_SAFE_UPDATES =0;

/* MARKET SEGMENTATION ANALYSIS-

 Identify the top 3 cities with the highest number of customers
 to determine key markets for targeted marketing and logistic optimization.
 */

SELECT location, count(*) as number_of_customer
FROM customers
GROUP BY location
ORDER BY count(customer_id) desc
LIMIT 3;

/* ENGAGEMENT DEPTH ANALYSIS-

 Determine how many customers fall into each order frequency category 
 based on the number of orders they have placed.
*/

WITH Custcount AS (
SELECT customer_id, COUNT(order_id) AS numberoforders
FROM orders
GROUP BY customer_id)

SELECT numberoforders,
COUNT(customer_id) AS customercount
FROM custcount
GROUP BY numberoforders
ORDER BY numberoforders ASC; 

/* PURCHASE HIGH-VALUE PRODUCTS-

 Total quantity n revenue of each products.
 
 */
 
SELECT product_id,sum(quantity) as total_qty,
sum(quantity*price_per_unit) as total_revenue 
FROM orderdetails
group by product_id
order by total_revenue desc;


/* 

Identify products where the average purchase quantity per order is 2 but with a high total revenue, 
suggesting premium product trends.

*/


SELECT product_id, avg(quantity) as avg_qty,sum(quantity*price_per_unit) as total_revenue
from orderdetails
group by product_id
having avg(quantity)=2
order by total_revenue desc;


/* CATEGORY-WISE CUSTOMER REACH 

For each product category, calculate the unique number of customers purchasing from it. 
This will help understand which categories have wider appeal across the customer base.

*/

SELECT p.category, COUNT(distinct o.customer_id) AS unique_customers
FROM product p
INNER JOIN orderdetails od ON p.product_id = od.product_id
INNER JOIN orders o On o.order_id = od.order_id
GROUP BY category
ORDER BY unique_customers DESC;



/* SALES TREND ANALYSIS-

Analyze the month-on-month percentage change in total sales to identify growth trends.

*/

WITH monthwise_orderdetails as
(
select date_format(order_date, '%Y-%m') as month, sum(total_amount) as Total_sales
from orders
group by month
order by month asc
)
select month, Total_sales,lag(Total_sales) over() as previous_month_sales,
concat(round(((Total_sales-lag(Total_sales) over())/lag(Total_sales) over())*100,2),"%")as mom_sales_percentage
from monthwise_orderdetails
;


/* AVERAGE ORDER VALUE FLUCTUATION

 Examine how the average order value changes month-on-month. 
Insights can guide pricing and promotional strategies to enhance order value.

*/

WITH monthwise_orderdetails as
(
select date_format(order_date, '%Y-%m') as month, round(avg(total_amount),2) as avg_order_value
from orders
group by month
order by month asc
)
select month, avg_order_value,lag(avg_order_value) over() as previous_month_avg,
round(avg_order_value-lag(avg_order_value) over(),2)as mom_change_in_avg
from monthwise_orderdetails
;

/* INVENTORY REFRESH RATE-

 Based on sales data, identify products with the fastest turnover rates, 
 suggesting high demand and the need for frequent restocking.
 
*/

select product_id,count(quantity) as num_of_qty_sold
from orderdetails
group by product_id
order by total_qty_sold desc;

/* LOW ENGAGEMENT PRODUCTS-

List products purchased by less than 40% of the customer base, 
indicating potential mismatches between inventory and customer interest.

*/

select p.product_id,p.name as product_name,count(distinct o.customer_id) as cus_count
from product p
inner join orderdetails od on p.product_id=od.product_id
inner join orders o on o.order_id=od.order_id
group by p.product_id,p.name
having count(distinct o.customer_id)<0.40*(SELECT COUNT(*)from customers);


/* CUSTOMER ACQUISTION TRENDS-

 Evaluate the month-on-month growth rate in the customer base 
 to understand the effectiveness of marketing campaigns and market expansion efforts.
 
 */

with firstpurchase as
(
select customer_id,date_format(min(order_date),'%Y-%m') as first_purchase_date
from orders
group by customer_id
)
select first_purchase_date,count(customer_id) as new_customers
from firstpurchase
group by first_purchase_date
order by first_purchase_date;

 
/* PEAK SALES PERIOD IDENTIFICATION 

Identify the months with the highest sales volume, aiding in planning for stock levels, 
marketing efforts, and staffing in anticipation of peak demand periods.

*/

select date_format(order_date,"%Y-%m") as month,sum(total_amount) as total_sales
from orders
group by date_format(order_date,"%Y-%m") 
order by total_sales desc;
