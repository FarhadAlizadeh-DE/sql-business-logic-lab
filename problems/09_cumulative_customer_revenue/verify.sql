-- VERIFY: Customer-day revenue series (paid/shipped only)

SELECT
  c.customer_id,
  c.full_name,
  o.order_ts::date AS day,
  SUM(oi.qty * oi.unit_price) AS daily_revenue
FROM customers c
JOIN orders o
  ON o.customer_id = c.customer_id
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid', 'shipped')
GROUP BY c.customer_id, c.full_name, o.order_ts::date
ORDER BY c.customer_id, day;
