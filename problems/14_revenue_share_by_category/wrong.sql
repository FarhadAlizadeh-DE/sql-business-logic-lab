-- WRONG: Computes total revenue by joining again and summing totals twice (double aggregation risk).
-- This can look right on small data but is fragile.

WITH cat AS (
  SELECT
    c.customer_id,
    c.full_name,
    p.category,
    SUM(oi.qty * oi.unit_price) AS category_revenue
  FROM customers c
  JOIN orders o
    ON o.customer_id = c.customer_id
  JOIN order_items oi
    ON oi.order_id = o.order_id
  JOIN products p
    ON p.product_id = oi.product_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY c.customer_id, c.full_name, p.category
)
SELECT
  customer_id,
  full_name,
  category,
  category_revenue,
  -- BUG: summing category_revenue after joining would be worse; even this pattern tempts double-summing.
  SUM(category_revenue) OVER (PARTITION BY customer_id) AS customer_total_revenue,
  ROUND(
    category_revenue::numeric / NULLIF(SUM(category_revenue) OVER (PARTITION BY customer_id), 0),
    4
  ) AS category_revenue_pct
FROM cat
ORDER BY customer_id, category;
