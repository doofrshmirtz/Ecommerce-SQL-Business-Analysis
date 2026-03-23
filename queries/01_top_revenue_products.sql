select * 
from orders 
limit 10;

select p.product_category_name,
count (oi.order_id) as total_orders,
round(sum(oi.price)::numeric, 2) as total_revenue
from order_items oi 
join products p on oi.product_id = p.product_id 
group by p.product_category_name 
order by total_revenue desc  
limit 10;

