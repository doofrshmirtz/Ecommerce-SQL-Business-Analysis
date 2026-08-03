/*
Business question:
What percentage of unique customers placed one delivered order
versus multiple delivered orders?

Purpose:
Measure repeat purchasing behaviour and identify customer-retention risk.

Tables used:
customers
orders

SQL skills demonstrated:
Subquery
JOIN
CASE
COUNT DISTINCT
Window function
Percentage calculation
GROUP BY
ORDER BY
*/

SELECT
    customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM (
    SELECT
        c.customer_unique_id,
        CASE
            WHEN COUNT(DISTINCT o.order_id) = 1
                THEN 'one_time_customer'
            ELSE 'repeat_customer'
        END AS customer_type
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id
) AS customer_segments
GROUP BY
    customer_type
ORDER BY
    total_customers DESC;
