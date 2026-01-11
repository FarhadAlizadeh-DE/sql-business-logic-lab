-- CORRECT: Count qualifying orders, not item rows.

SELECT
  c.customer_id,
  c.full_name,
  COUNT(DISTINCT o.order_id) AS qualifying_orders
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.customer_id, c.full_name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY c.customer_id;
