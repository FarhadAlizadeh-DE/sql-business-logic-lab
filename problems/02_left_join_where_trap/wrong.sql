-- WRONG: The WHERE clause filters out NULLs created by the LEFT JOIN.
-- Result: customers with zero paid/shipped orders disappear.

SELECT
  c.customer_id,
  c.full_name,
  COUNT(o.order_id) AS paid_shipped_orders
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
WHERE o.status IN ('paid', 'shipped')
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
