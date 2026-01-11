-- WRONG: First purchase date computed globally and at item-level grain.
-- Problems:
-- 1) MIN(...) OVER () is global (not per customer).
-- 2) Item-level join produces duplicated rows (not customer-day grain).

SELECT
  c.customer_id,
  c.full_name,
  o.order_ts::date AS day,
  (oi.qty * oi.unit_price) AS item_revenue,
  MIN(o.order_ts::date) OVER () AS first_purchase_day_bogus,
  (o.order_ts::date - MIN(o.order_ts::date) OVER ()) AS days_since_first_bogus
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
ORDER BY c.customer_id, day;
