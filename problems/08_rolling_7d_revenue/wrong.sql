-- WRONG / WEAK: Rolling window over only existing days.
-- If some calendar days have no orders, they disappear, and the "7-day" window becomes "last 7 rows".

WITH daily AS (
  SELECT
    o.order_ts::date AS day,
    SUM(oi.qty * oi.unit_price) AS daily_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY o.order_ts::date
)
SELECT
  day,
  daily_revenue,
  SUM(daily_revenue) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_revenue
FROM daily
ORDER BY day;
