-- Find customers with missing state
SELECT *
FROM customers
WHERE state IS NULL;

-- Find orders with missing status
SELECT *
FROM orders
WHERE status IS NULL;

-- Check for orphaned order_items (should be zero rows)
SELECT oi.*
FROM order_items oi
LEFT JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_id IS NULL;

-- Check for duplicate customer names (not always wrong, but worth flagging)
SELECT customer_name, COUNT(*) AS cnt
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;
