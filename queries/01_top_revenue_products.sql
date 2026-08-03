/*
Business question:
Which product categories generate the highest item revenue?

Purpose:
Identify the product categories contributing most strongly to
platform revenue.

Tables used:
order_items
products

SQL skills demonstrated:
JOIN
GROUP BY
SUM
COUNT
ORDER BY
*/

SELECT
    p.product_category_name,
    COUNT(oi.order_id) AS item_count,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_revenue DESC
LIMIT 10;
