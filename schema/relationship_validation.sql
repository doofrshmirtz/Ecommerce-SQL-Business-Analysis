/*
Purpose:
Validate the logical relationships used in the Olist analysis.

The PostgreSQL tables were created through Pandas and currently do not
contain formally declared primary-key or foreign-key constraints.
*/

-- Duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS row_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- Duplicate product IDs
SELECT
    product_id,
    COUNT(*) AS row_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- Duplicate seller IDs
SELECT
    seller_id,
    COUNT(*) AS row_count
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;


-- Order items without matching orders
SELECT COUNT(*) AS orphaned_order_items
FROM order_items AS oi
LEFT JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Order items without matching products
SELECT COUNT(*) AS orphaned_product_items
FROM order_items AS oi
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Order items without matching sellers
SELECT COUNT(*) AS orphaned_seller_items
FROM order_items AS oi
LEFT JOIN sellers AS s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;


-- Orders without matching customer rows
SELECT COUNT(*) AS orphaned_orders
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- Payments without matching orders
SELECT COUNT(*) AS orphaned_payments
FROM payments AS p
LEFT JOIN orders AS o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Reviews without matching orders
SELECT COUNT(*) AS orphaned_reviews
FROM reviews AS r
LEFT JOIN orders AS o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Confirm whether review_id contains duplicates
SELECT
    review_id,
    COUNT(*) AS row_count
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;
