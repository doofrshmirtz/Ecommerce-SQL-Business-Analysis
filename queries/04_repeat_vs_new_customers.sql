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
    customer_type,
    COUNT(*)                                    AS total_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM (
    SELECT 
        c.customer_id,
        CASE 
            WHEN COUNT(DISTINCT o.order_id) = 1 THEN 'new_customer'
            ELSE 'repeat_customer'
        END AS customer_type
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_id
) AS customer_segments
GROUP BY customer_type
ORDER BY total_customers DESC;

