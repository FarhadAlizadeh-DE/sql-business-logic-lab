-- CORRECT: Aggregate to customer-day grain, then compute cumulative sum per customer.

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
  SUM(daily_revenue) OVER (
    PARTITION BY customer_id
    ORDER BY day
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_revenue
FROM daily
ORDER BY customer_id, day;
