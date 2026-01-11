-- VERIFY: per-order totals (paid/shipped only)

SELECT
  o.customer_id,
  o.order_id,
  o.order_ts::date AS day,
  SUM(oi.qty * oi.unit_price) AS order_value
FROM orders o
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY o.customer_id, o.order_id, o.order_ts::date
ORDER BY o.customer_id, o.order_id;
