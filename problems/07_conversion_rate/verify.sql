-- VERIFY: Show the conversion flag per customer (easy to sanity-check).

SELECT
  c.customer_id,
  c.full_name,
  CASE WHEN EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status IN ('paid','shipped')
  ) THEN 1 ELSE 0 END AS is_converted
FROM customers c
ORDER BY c.customer_id;
