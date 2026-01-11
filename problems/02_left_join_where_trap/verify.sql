-- VERIFY: Conditional aggregation.
-- Count only qualifying statuses, while keeping all customers.

SELECT
  c.customer_id,
  c.full_name,
  SUM(CASE WHEN o.status IN ('paid', 'shipped') THEN 1 ELSE 0 END) AS paid_shipped_orders
FROM customers c
LEFT JOIN orders o
  ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
