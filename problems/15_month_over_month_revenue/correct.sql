-- CORRECT: Monthly aggregation + ordered LAG + safe MoM calculation.

WITH monthly AS (
  SELECT
    DATE_TRUNC('month', o.order_ts)::date AS month,
    SUM(oi.qty * oi.unit_price) AS monthly_revenue
  FROM orders o
  JOIN order_items oi
    ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY DATE_TRUNC('month', o.order_ts)
),
with_prev AS (
  SELECT
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue
  FROM monthly
)
SELECT
  month,
  monthly_revenue,
  previous_month_revenue,
  ROUND(
    (monthly_revenue - previous_month_revenue)
    / NULLIF(previous_month_revenue, 0),
    4
  ) AS mom_change_pct
FROM with_prev
ORDER BY month;
