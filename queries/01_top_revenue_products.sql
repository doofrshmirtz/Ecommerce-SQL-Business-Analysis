/*
Business question:
Which product categories generate the highest delivered-order revenue?

Purpose:
Identify the categories contributing most strongly to platform revenue.

Tables used:
orders
order_items
products

SQL skills demonstrated:
JOIN
GROUP BY
SUM
COUNT DISTINCT
ORDER BY
*/

select p.product_category_name,
count (oi.order_id) as total_orders,
round(sum(oi.price)::numeric, 2) as total_revenue
from order_items oi 
join products p on oi.product_id = p.product_id 
group by p.product_category_name 
order by total_revenue desc  
limit 10;

