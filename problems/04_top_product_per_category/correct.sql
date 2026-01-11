-- CORRECT: Rank products within each category by revenue, then pick rank = 1.
-- Tie-break: revenue desc, product_id asc.

WITH product_revenue AS (
  SELECT
    p.category,
    p.product_id,
    p.product_name,
    SUM(oi.qty * oi.unit_price) AS revenue
  FROM products p
  JOIN order_items oi
    ON oi.product_id = p.product_id
  JOIN orders o
    ON o.order_id = oi.order_id
  WHERE o.status IN ('paid', 'shipped')
  GROUP BY p.category, p.product_id, p.product_name
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY category
      ORDER BY revenue DESC, product_id ASC
    ) AS rn
  FROM product_revenue
)
SELECT
  category,
  product_id,
  product_name,
  revenue
FROM ranked
WHERE rn = 1
ORDER BY category, product_id;
