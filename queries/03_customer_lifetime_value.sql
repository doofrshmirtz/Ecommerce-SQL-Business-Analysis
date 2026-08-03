/*
Business question:
What is the distribution of customer lifetime value?

Purpose:
Understand how much revenue individual customers generate.

Tables used:
customers
orders
order_items

SQL skills demonstrated:
CTE or subquery
JOIN
SUM
GROUP BY
ORDER BY
*/

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
