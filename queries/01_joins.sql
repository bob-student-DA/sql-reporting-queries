-- Q1: List all orders with customer name and state
SELECT
  o.order_id,
  o.order_date,
  c.customer_name,
  c.state,
  o.status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_date;

-- Q2: Order line detail with product names and extended price
SELECT
  o.order_id,
  o.order_date,
  c.customer_name,
  p.product_name,
  oi.quantity,
  p.unit_price,
  (oi.quantity * p.unit_price) AS line_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = oi.product_id
ORDER BY o.order_id, line_revenue DESC;
