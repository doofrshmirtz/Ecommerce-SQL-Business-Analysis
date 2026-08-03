/*
Business question:
Which customer states generated the highest delivered-order item revenue?

Purpose:
Identify the strongest state-level geographic markets by order volume,
item revenue, and average item revenue per order.

Tables used:
customers
orders
order_items

SQL skills demonstrated:
Multi-table JOIN
COUNT DISTINCT
SUM
Division
ROUND
GROUP BY
ORDER BY
*/

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_item_revenue,
    ROUND(
        SUM(oi.price)::numeric
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS avg_item_revenue_per_order
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    c.customer_state
ORDER BY
    total_item_revenue DESC;
