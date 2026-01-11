-- WRONG / FRAGILE: MAX(order_ts) + join-back.
-- If a customer has two orders with the same latest timestamp, this returns multiple rows.

WITH latest_ts AS (
  SELECT
    customer_id,
    MAX(order_ts) AS max_order_ts
  FROM orders
  GROUP BY customer_id
)
SELECT
  c.customer_id,
  c.full_name,
  o.order_id,
  o.order_ts,
  o.status
FROM customers c
LEFT JOIN latest_ts lt
  ON lt.customer_id = c.customer_id
LEFT JOIN orders o
  ON o.customer_id = lt.customer_id
 AND o.order_ts = lt.max_order_ts
ORDER BY c.customer_id, o.order_id;
