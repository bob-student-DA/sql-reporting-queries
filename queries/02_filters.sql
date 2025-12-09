/* ============================================================
   02_filters.sql — Filtering patterns for business questions
   Skills: WHERE, AND/OR, IN, BETWEEN, LIKE, IS NULL, CASE
   ============================================================ */

-- Q1: Orders that are currently in progress (common operational filter)
SELECT
  order_id,
  customer_id,
  order_date,
  status
FROM orders
WHERE status IN ('Processing')
ORDER BY order_date;

-- Q2: Orders in a specific date range (BETWEEN)
SELECT
  order_id,
  customer_id,
  order_date,
  status
FROM orders
WHERE order_date BETWEEN '2024-04-01' AND '2024-04-30'
ORDER BY order_date;

-- Q3: Orders for a specific customer (parameterizable filter)
-- Tip: swap 1 for another customer_id
SELECT
  o.order_id,
  o.order_date,
  o.status,
  c.customer_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.customer_id = 1
ORDER BY o.order_date;

-- Q4: Customers from a set of states (IN list)
SELECT
  customer_id,
  customer_name,
  state,
  created_at
FROM customers
WHERE state IN ('NV', 'AZ')
ORDER BY state, created_at;

-- Q5: Products in a category + price threshold (AND)
SELECT
  product_id,
  product_name,
  category,
  unit_price
FROM products
WHERE category = 'Gadgets'
  AND unit_price >= 25.00
ORDER BY unit_price DESC;

-- Q6: Find customers by name pattern (LIKE)
SELECT
  customer_id,
  customer_name,
  state
FROM customers
WHERE customer_name LIKE '%Valley%'
ORDER BY customer_name;

-- Q7: Orders not yet shipped (NULL handling)
SELECT
  order_id,
  customer_id,
  order_date,
  target_ship_date,
  actual_ship_date,
  status
FROM orders
WHERE actual_ship_date IS NULL
ORDER BY order_date;

-- Q8: Shipped orders that missed the target ship date (business exception filter)
SELECT
  order_id,
  customer_id,
  order_date,
  target_ship_date,
  actual_ship_date,
  status
FROM orders
WHERE actual_ship_date IS NOT NULL
  AND target_ship_date IS NOT NULL
  AND actual_ship_date > target_ship_date
ORDER BY actual_ship_date DESC;

-- Q9: Revenue lines above a threshold (filter on computed expression)
SELECT
  o.order_id,
  c.customer_name,
  p.product_name,
  oi.quantity,
  p.unit_price,
  (oi.quantity * p.unit_price) AS line_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id
WHERE (oi.quantity * p.unit_price) >= 50.00
ORDER BY line_revenue DESC;

-- Q10: Identify “high-value” orders (filter using HAVING)
-- (This introduces HAVING because it’s the correct filter for aggregates.)
SELECT
  o.order_id,
  c.customer_name,
  ROUND(SUM(oi.quantity * p.unit_price), 2) AS order_revenue
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id, c.customer_name
HAVING SUM(oi.quantity * p.unit_price) >= 75.00
ORDER BY order_revenue DESC;

-- Q11: Flag orders as On-Time / Late / Pending (CASE for reporting filters)
SELECT
  order_id,
  order_date,
  target_ship_date,
  actual_ship_date,
  CASE
    WHEN actual_ship_date IS NULL THEN 'Pending'
    WHEN target_ship_date IS NULL THEN 'No Target Date'
    WHEN actual_ship_date <= target_ship_date THEN 'On-Time'
    ELSE 'Late'
  END AS ship_performance
FROM orders
ORDER BY order_date;

-- Q12: Show only Late orders (filter on CASE via subquery)
WITH labeled AS (
  SELECT
    order_id,
    order_date,
    target_ship_date,
    actual_ship_date,
    CASE
      WHEN actual_ship_date IS NULL THEN 'Pending'
      WHEN target_ship_date IS NULL THEN 'No Target Date'
      WHEN actual_ship_date <= target_ship_date THEN 'On-Time'
      ELSE 'Late'
    END AS ship_performance
  FROM orders
)
SELECT *
FROM labeled
WHERE ship_performance = 'Late'
ORDER BY actual_ship_date DESC;
