-- VERIFY: Show qualifying order_ids per customer (easy to eyeball).

SELECT
  c.customer_id,
  c.full_name,
  o.order_id,
  o.status,
  o.order_ts::date AS day
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
WHERE o.status IN ('paid','shipped')
ORDER BY c.customer_id, o.order_id;
