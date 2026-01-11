-- WRONG: Missing PARTITION BY customer -> cumulative sum mixes all customers.
-- Also computed at customer-day grain but the window is global (bad).

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
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY c.customer_id, c.full_name, o.order_ts::date
)
SELECT
  customer_id,
  full_name,
  day,
  daily_revenue,
  SUM(daily_revenue) OVER (ORDER BY customer_id, day) AS cumulative_revenue_bogus
FROM daily
ORDER BY customer_id, day;
