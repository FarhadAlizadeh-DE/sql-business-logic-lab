-- WRONG / FRAGILE: NOT IN becomes dangerous if the subquery can contain NULL.
-- To demonstrate, we intentionally UNION a NULL into the subquery result.

SELECT
  c.customer_id,
  c.full_name
FROM customers c
WHERE c.customer_id NOT IN (
  SELECT o.customer_id
  FROM orders o
  WHERE o.status IN ('cancelled', 'refunded')

  UNION ALL
  SELECT NULL
)
ORDER BY c.customer_id;
