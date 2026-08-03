/*
Business question:
Which customers generated the highest historical item revenue?

Purpose:
Measure historical customer value using delivered-order item revenue,
order frequency, and the period between first and last purchases.

Tables used:
customers
orders
order_items

SQL skills demonstrated:
Subquery
Multi-table JOIN
COUNT DISTINCT
SUM
MIN
MAX
GROUP BY
ORDER BY
*/

SELECT
    customer_summary.customer_unique_id,
    customer_summary.total_orders,
    customer_summary.total_item_revenue,
    ROUND(
        customer_summary.total_item_revenue
        / NULLIF(customer_summary.total_orders, 0),
        2
    ) AS avg_item_revenue_per_order,
    customer_summary.first_order,
    customer_summary.last_order
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.price)::numeric, 2) AS total_item_revenue,
        MIN(o.order_purchase_timestamp::date) AS first_order,
        MAX(o.order_purchase_timestamp::date) AS last_order
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
) AS customer_summary
ORDER BY
    customer_summary.total_item_revenue DESC
LIMIT 20;
