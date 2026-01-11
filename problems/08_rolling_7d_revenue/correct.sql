-- CORRECT: Generate a complete calendar series, left join daily revenue, fill missing days with 0,
-- then compute rolling 7-day revenue.

WITH bounds AS (
  SELECT
    MIN(o.order_ts::date) AS min_day,
    MAX(o.order_ts::date) AS max_day
  FROM orders o
  WHERE o.status IN ('paid', 'shipped')
),
calendar AS (
  SELECT
    gs::date AS day
  FROM bounds b
  CROSS JOIN generate_series(b.min_day, b.max_day, interval '1 day') AS gs
),
daily AS (
  SELECT
    o.order_ts::date AS day,
    SUM(oi.qty * oi.unit_price) AS daily_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY o.order_ts::date
),
daily_filled AS (
  SELECT
    c.day,
    COALESCE(d.daily_revenue, 0) AS daily_revenue
  FROM calendar c
  LEFT JOIN daily d
    ON d.day = c.day
)
SELECT
  day,
  daily_revenue,
  SUM(daily_revenue) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7d_revenue
FROM daily_filled
ORDER BY day;
