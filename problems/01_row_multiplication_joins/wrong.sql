SELECT
  c.customer_id,
  c.full_name,
  SUM(oi.qty * oi.unit_price) AS revenue
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
-- BUG: joining orders again at customer level multiplies item rows
JOIN orders o2
  ON o2.customer_id = c.customer_id
WHERE o.status IN ('paid', 'shipped')
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
