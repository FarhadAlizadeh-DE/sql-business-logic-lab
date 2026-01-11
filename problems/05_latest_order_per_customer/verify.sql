-- VERIFY: Show ranked orders so ties are visible.

SELECT
  o.customer_id,
  o.order_id,
  o.order_ts,
  o.status,
  ROW_NUMBER() OVER (
    PARTITION BY o.customer_id
    ORDER BY o.order_ts DESC, o.order_id DESC
  ) AS rn
FROM orders o
ORDER BY o.customer_id, rn, o.order_id DESC;
