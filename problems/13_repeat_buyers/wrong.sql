-- WRONG: Joining order_items and counting rows inflates "order count" into "item rows".

SELECT
  c.customer_id,
  c.full_name,
  COUNT(*) AS qualifying_orders_bogus
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.customer_id, c.full_name
HAVING COUNT(*) >= 2
ORDER BY c.customer_id;
