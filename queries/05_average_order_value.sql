/*
Business question:
How did average item revenue per delivered order change by month?

Purpose:
Understand whether item revenue generated per delivered order
increased or decreased over time.

Tables used:
orders
order_items

SQL skills demonstrated:
JOIN
DATE_TRUNC
TO_CHAR
COUNT DISTINCT
SUM
Division
ROUND
GROUP BY
ORDER BY
*/

SELECT
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp::date
    ) AS month,
    TO_CHAR(
        DATE_TRUNC('month', o.order_purchase_timestamp::date),
        'YYYY-MM'
    ) AS month_label,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS monthly_item_revenue,
    ROUND(
        SUM(oi.price)::numeric
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS avg_item_revenue_per_order
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    DATE_TRUNC('month', o.order_purchase_timestamp::date)
ORDER BY
    DATE_TRUNC('month', o.order_purchase_timestamp::date) ASC;
