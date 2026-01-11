-- CORRECT: Rank orders per customer by timestamp, then by order_id.
-- Tie-break: latest order_ts, then highest order_id.

WITH ranked AS (
  SELECT
    o.*,
    ROW_NUMBER() OVER (
      PARTITION BY o.customer_id
      ORDER BY o.order_ts DESC, o.order_id DESC
    ) AS rn
  FROM orders o
)
SELECT
  c.customer_id,
  c.full_name,
  r.order_id,
  r.order_ts,
  r.status
FROM customers c
LEFT JOIN ranked r
  ON r.customer_id = c.customer_id
 AND r.rn = 1
ORDER BY c.customer_id;
