SELECT
  c.customer_id,
  c.full_name,
  COALESCE(SUM(oi.qty * oi.unit_price), 0) AS revenue
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
 AND o.status IN ('paid', 'shipped')
LEFT JOIN order_items oi
  ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
