-- CORRECT: Aggregate to customer-day, then compute first purchase day per customer
-- and the day offset.

WITH daily AS (
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
  WHERE o.status IN ('paid','shipped')
  GROUP BY c.customer_id, c.full_name, o.order_ts::date
),
with_first AS (
  SELECT
    *,
    MIN(day) OVER (PARTITION BY customer_id) AS first_purchase_day
  FROM daily
)
SELECT
  customer_id,
  full_name,
  day,
  daily_revenue,
  first_purchase_day,
  (day - first_purchase_day) AS days_since_first_purchase
FROM with_first
ORDER BY customer_id, day;
