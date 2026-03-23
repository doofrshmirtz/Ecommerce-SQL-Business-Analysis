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

SELECT 
    customer_summary.customer_id,
    customer_summary.total_orders,
    customer_summary.total_spent,
    ROUND((customer_summary.total_spent / customer_summary.total_orders)::numeric, 2) AS avg_order_value,
    customer_summary.first_order,
    customer_summary.last_order
FROM (
    SELECT 
        c.customer_id,
        COUNT(DISTINCT o.order_id)           AS total_orders,
        ROUND(SUM(oi.price)::numeric, 2)     AS total_spent,
        MIN(o.order_purchase_timestamp::date) AS first_order,
        MAX(o.order_purchase_timestamp::date) AS last_order
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_id
) AS customer_summary
ORDER BY total_spent DESC
LIMIT 20;

SELECT 
    customer_type,
    COUNT(*)                                    AS total_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM (
    SELECT 
        c.customer_id,
        CASE 
            WHEN COUNT(DISTINCT o.order_id) = 1 THEN 'new_customer'
            ELSE 'repeat_customer'
        END AS customer_type
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_id
) AS customer_segments
GROUP BY customer_type
ORDER BY total_customers DESC;

