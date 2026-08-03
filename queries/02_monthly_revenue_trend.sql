/*
Business question:
How did delivered-order revenue change by month?

Purpose:
Measure sales growth, seasonality and unusual revenue peaks.

Tables used:
orders
order_items

SQL skills demonstrated:
JOIN
DATE_TRUNC
SUM
GROUP BY
ORDER BY
*/

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



