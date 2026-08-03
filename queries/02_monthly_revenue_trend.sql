/*
Business question:
How did item revenue from delivered orders change by month?

Purpose:
Measure sales growth, seasonality, and unusual monthly revenue peaks.

Tables used:
orders
order_items

SQL skills demonstrated:
JOIN
DATE_TRUNC
TO_CHAR
COUNT DISTINCT
SUM
GROUP BY
ORDER BY
*/

SELECT
    TO_CHAR(
        DATE_TRUNC('month', o.order_purchase_timestamp),
        'YYYY-MM'
    ) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS monthly_revenue
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY
    DATE_TRUNC('month', o.order_purchase_timestamp) ASC;
