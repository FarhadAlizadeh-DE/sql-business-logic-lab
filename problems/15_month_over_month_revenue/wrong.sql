-- WRONG: Unsafe MoM calculation (no NULL handling, fragile logic).

WITH monthly AS (
  SELECT
    DATE_TRUNC('month', o.order_ts)::date AS month,
    SUM(oi.qty * oi.unit_price) AS monthly_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY DATE_TRUNC('month', o.order_ts)
)
SELECT
  month,
  monthly_revenue,
  LAG(monthly_revenue) OVER () AS previous_month_revenue,
  (monthly_revenue - LAG(monthly_revenue) OVER ())
    / LAG(monthly_revenue) OVER () AS mom_change_pct_bogus
FROM monthly;
