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

SELECT 
    TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp::date), 'YYYY-MM') AS month,
    COUNT(DISTINCT o.order_id)                                                  AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)                                            AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp::date)
ORDER BY DATE_TRUNC('month', o.order_purchase_timestamp::date) ASC;



