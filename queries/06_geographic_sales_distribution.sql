/*
Business question:
Which customer states and cities generate the highest revenue?

Purpose:
Identify the strongest geographic markets.

Tables used:
customers
orders
order_items

SQL skills demonstrated:
multi-table JOIN
SUM
COUNT DISTINCT
GROUP BY
ORDER BY
*/

SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)     AS total_revenue,
    ROUND((SUM(oi.price) / COUNT(DISTINCT o.order_id))::numeric, 2) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC;
