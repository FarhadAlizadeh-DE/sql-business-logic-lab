-- CORRECT: NOT EXISTS expresses "never had" safely, NULL-proof.

SELECT
  c.customer_id,
  c.full_name
FROM customers c
WHERE NOT EXISTS (
  SELECT 1
  FROM orders o
  WHERE o.customer_id = c.customer_id
    AND o.status IN ('cancelled', 'refunded')
)
ORDER BY c.customer_id;
