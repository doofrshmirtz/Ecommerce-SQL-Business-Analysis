/*
Business question:
How did average order value change by month?

Purpose:
Understand whether customer spending per order increased or decreased.

Tables used:
orders
order_items

SQL skills demonstrated:
CTE
DATE_TRUNC
SUM
COUNT DISTINCT
division
ROUND
*/


SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp::date) AS month,
    TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp::date), 'YYYY-MM') AS month_label,
    COUNT(DISTINCT o.order_id)                            AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2)                      AS total_revenue,
    ROUND((SUM(oi.price) / COUNT(DISTINCT o.order_id))::numeric, 2) AS avg_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp::date)
ORDER BY DATE_TRUNC('month', o.order_purchase_timestamp::date) ASC;
