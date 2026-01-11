-- CORRECT: Put the filter in the JOIN condition so NULL-extended rows remain.
-- Customers with no qualifying orders will show count = 0.

SELECT
  c.customer_id,
  c.full_name,
  COUNT(o.order_id) AS paid_shipped_orders
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
 AND o.status IN ('paid', 'shipped')
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
