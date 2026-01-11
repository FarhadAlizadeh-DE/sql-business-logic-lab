-- CORRECT: Count customers at the customer grain.
-- A customer is "converted" if they have >=1 paid/shipped order.

WITH converted AS (
  SELECT
    c.customer_id,
    CASE WHEN EXISTS (
      SELECT 1
      FROM orders o
      WHERE o.customer_id = c.customer_id
        AND o.status IN ('paid','shipped')
    ) THEN 1 ELSE 0 END AS is_converted
  FROM customers c
)
SELECT
  COUNT(*) AS total_customers,
  SUM(is_converted) AS converted_customers,
  ROUND(SUM(is_converted)::numeric / NULLIF(COUNT(*), 0), 4) AS conversion_rate
FROM converted;
