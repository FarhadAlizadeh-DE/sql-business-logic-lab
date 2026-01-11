-- CORRECT: compute order totals (one row per order), then median per customer.

WITH order_totals AS (
  SELECT
    o.customer_id,
    o.order_id,
    SUM(oi.qty * oi.unit_price) AS order_value
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY o.customer_id, o.order_id
)
SELECT
  c.customer_id,
  c.full_name,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ot.order_value) AS median_order_value
FROM customers c
LEFT JOIN order_totals ot
  ON ot.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;
