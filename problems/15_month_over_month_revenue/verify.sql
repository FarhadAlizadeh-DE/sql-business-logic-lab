-- VERIFY: Monthly revenue (paid/shipped only)

SELECT
  DATE_TRUNC('month', o.order_ts)::date AS month,
  SUM(oi.qty * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi
  ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY DATE_TRUNC('month', o.order_ts)
ORDER BY month;
