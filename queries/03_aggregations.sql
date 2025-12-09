-- Q1: Revenue by customer (business question)
SELECT
  c.customer_name,
  ROUND(SUM(oi.quantity * p.unit_price), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;

-- Q2: Average order value (simple recurring KPI)
WITH order_totals AS (
  SELECT
    o.order_id,
    SUM(oi.quantity * p.unit_price) AS order_revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p ON p.product_id = oi.product_id
  GROUP BY o.order_id
)
SELECT
  ROUND(AVG(order_revenue), 2) AS avg_order_value
FROM order_totals;
