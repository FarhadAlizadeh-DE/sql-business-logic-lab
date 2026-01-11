-- VERIFY: Daily revenue only for days that appear in the data (no date gaps filled)

SELECT
  o.order_ts::date AS day,
  SUM(oi.qty * oi.unit_price) AS daily_revenue
FROM orders o
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid', 'shipped')
GROUP BY o.order_ts::date
ORDER BY day;
