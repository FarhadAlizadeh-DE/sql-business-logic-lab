-- VERIFY: Anti-join using LEFT JOIN + IS NULL (also safe and common).

SELECT
  c.customer_id,
  c.full_name
FROM customers c
LEFT JOIN orders bad
  ON bad.customer_id = c.customer_id
 AND bad.status IN ('cancelled', 'refunded')
WHERE bad.order_id IS NULL
ORDER BY c.customer_id;
