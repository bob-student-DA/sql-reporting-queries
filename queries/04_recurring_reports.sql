-- Monthly revenue trend (recurring reporting pattern)
SELECT
  strftime('%Y-%m', o.order_date) AS month,
  ROUND(SUM(oi.quantity * p.unit_price), 2) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY month;

-- Shipping delay rate (operational metric)
SELECT
  COUNT(*) AS total_orders,
  SUM(CASE WHEN actual_ship_date > target_ship_date THEN 1 ELSE 0 END) AS delayed_orders,
  ROUND(
    1.0 * SUM(CASE WHEN actual_ship_date > target_ship_date THEN 1 ELSE 0 END) / COUNT(*),
    3
  ) AS delayed_rate
FROM orders
WHERE actual_ship_date IS NOT NULL
  AND target_ship_date IS NOT NULL;
